//
//  APICaller.swift
//  WhereToGo
//
//  Created by 권정근 on 8/5/24.
//

import Foundation

struct Constants {
    static let API_KEY = "jlK%2B0ig7iLAbdOuTJsnkp6n0RdeEMtGKsw53jEMbKm3PcB7NFTSeUrnXixogiuvNtHQXeqxgV88buRZvTjG73w%3D%3D"
    static let baseURL = "https://apis.data.go.kr/B551011/KorService1"
}

class APICaller {
    static let shared = APICaller()
    
    func getAttractions(completion: @escaping (String) -> Void) {
        //        guard let url = URL(string: "\(Constants.baseURL)/searchKeyword1?serviceKey=\(Constants.API_KEY)&numOfRows=20&pageNo=1&MobileOS=IOS&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&keyword=전북&contentTypeId=12") else {
        //            return
        //        }
        
        guard let url = URL(string: "https://apis.data.go.kr/B551011/KorService1/searchKeyword1?serviceKey=jlK%2B0ig7iLAbdOuTJsnkp6n0RdeEMtGKsw53jEMbKm3PcB7NFTSeUrnXixogiuvNtHQXeqxgV88buRZvTjG73w%3D%3D&numOfRows=20&pageNo=1&MobileOS=IOS&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&keyword=%EC%A0%84%EB%B6%81&contentTypeId=12") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                // 데이터를 String으로 변환 후 JSONSerialization 사용
                if let jsonString = String(data: data, encoding: .utf8),
                   let jsonData = jsonString.data(using: .utf8) {
                    let results = try JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed)
                    print(results)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
