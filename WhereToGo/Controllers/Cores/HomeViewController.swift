//
//  HomeViewController.swift
//  WhereToGo
//
//  Created by 권정근 on 8/1/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 440))
        homeFeedTable.tableHeaderView = headerView
        
        homeFeedTableDelegate()
        configureNaviBar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let padding: CGFloat = 5
        homeFeedTable.frame = view.bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    // MARK: - Functions
    /// homeFeedTable Delegate 설정 함수
    private func homeFeedTableDelegate() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    /// navigationBarItems 설정 함수
    private func configureNaviBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(didTappedAlarm)),
            UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(didTappedChat))
        ]
        navigationController?.navigationBar.tintColor = .label
    }
    
    /// navigationbarbutton 중에 Alarm 버튼 함수
    @objc private func didTappedAlarm() {
        print("didTappedAlarm() - Tapped")
    }
    
    /// navigationbarbutton 중에 Chat 버튼 함수
    @objc private func didTappedChat() {
        print("didTappedChat() - Tapped")
    }
}

// MARK: - Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .clear  // 배경색을 투명하게 설정
//        return headerView  // 모든 섹션에 대해 빈 뷰를 반환합니다
//    }
}
