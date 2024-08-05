//
//  APICaller.swift
//  WhereToGo
//
//  Created by 권정근 on 8/5/24.
//

import Foundation

struct Constants {
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }()

    static let baseURL = "https://apis.data.go.kr/B551011/KorService1"
}

class APICaller {
    static let shared = APICaller()
    
    func getAttractions(completion: @escaping ([Attraction]?) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/searchKeyword1?serviceKey=\(Constants.apiKey)&numOfRows=20&pageNo=1&MobileOS=IOS&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&keyword=%EC%A0%84%EB%B6%81&contentTypeId=12") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(AttractionResponse.self, from: data)
                let attractions = decodedResponse.response.body.items.item
                completion(attractions)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Received JSON: \(jsonString)")
                }
                completion(nil)
            }

        }
        task.resume()
    }
}



//import Foundation
//
//struct Constants {
//
//    static let apiKey: String = {
//        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
//            fatalError("API_KEY not found in Info.plist")
//        }
//        return key
//    }()
//
//    static let baseURL = "https://apis.data.go.kr/B551011/KorService1"
//}
//
//class APICaller {
//    static let shared = APICaller()
//
//    func getAttractions(completion: @escaping ([Attraction]?) -> Void) {
//        guard let url = URL(string: "https://apis.data.go.kr/B551011/KorService1/searchKeyword1?serviceKey=\(Constants.apiKey)&numOfRows=20&pageNo=1&MobileOS=IOS&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&keyword=%EC%A0%84%EB%B6%81&contentTypeId=12") else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//
//            do {
//                // 데이터를 디코딩합니다.
//                let decodedResponse = try JSONDecoder().decode(AttractionResponse.self, from: data)
//                let attractions = decodedResponse.response.body.items.item
//                completion(attractions)
//            } catch {
//                print(error.localizedDescription)
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//}
