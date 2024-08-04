//
//  HomeViewController.swift
//  WhereToGo
//
//  Created by 권정근 on 8/1/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    let sectionTitles: [String] = ["관광지", "쇼핑", "숙박", "음식", "축제"]
    
    // MARK: - UI Components
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    // 상태 표시줄 배경색 뷰
    private let statusBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground// 원하는 색상으로 설정
        return view
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 440))
        homeFeedTable.tableHeaderView = headerView
        
        // 상태 표시줄 배경색 뷰 추가
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(statusBarBackgroundView)
            window.bringSubviewToFront(statusBarBackgroundView)
        }
        
        homeFeedTableDelegate()
        configureNaviBar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let padding: CGFloat = 5
        homeFeedTable.frame = view.bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        
        // 상태 표시줄 배경색 뷰의 프레임 설정
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        statusBarBackgroundView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: statusBarHeight)
    }
    
    // MARK: - Functions
    /// homeFeedTable Delegate 설정 함수
    private func homeFeedTableDelegate() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    /// navigationBarItems 설정 함수
    private func configureNaviBar() {
        
        // 로고 이미지를 설정
        let originalImage = UIImage(named: "WhereToGoLogo.png")
        let scaledSize = CGSize(width: 40, height: 40) // 시스템 버튼과 비슷한 크기
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        originalImage?.draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 원본 이미지 색상을 유지하기 위해 렌더링 모드를 .alwaysOriginal로 설정
        let originalColorImage = scaledImage?.withRenderingMode(.alwaysOriginal)
        
        let barButton = UIBarButtonItem(image: originalColorImage, style: .plain, target: self, action: #selector(didTappedLogo))
        navigationItem.leftBarButtonItem = barButton
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(didTappedAlarm)),
            UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(didTappedBookmark))
        ]
        navigationController?.navigationBar.tintColor = .label
    }
    
    /// navigaitonbarbutton 중에 logo 함수
    @objc private func didTappedLogo() {
        print("didTappedLogo() - Tapped")
    }
    
    /// navigationbarbutton 중에 Alarm 버튼 함수
    @objc private func didTappedAlarm() {
        print("didTappedAlarm() - Tapped")
    }
    
    /// navigationbarbutton 중에 Chat 버튼 함수
    @objc private func didTappedBookmark() {
        print("didTappedBookmark() - Tapped")
    }
}

// MARK: - Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
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
    
    // 테이블 섹션에 타이틀 설정 함수
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // 테이블 섹션에 타이틀의 텍스트 설정 함수
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 10, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
    }
    
    // 화면을 내릴 때, 네비게이션 바 부분이 밀려서 올라가게 하는 함수
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
}
