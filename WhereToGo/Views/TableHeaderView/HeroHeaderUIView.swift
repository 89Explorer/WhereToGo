//
//  HeroHeaderUIView.swift
//  WhereToGo
//
//  Created by 권정근 on 8/2/24.
//

import UIKit

class HeroHeaderUIView: UIView {

    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.layer.cornerRadius = 10
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true // 스크롤 방향 잠금
        return scrollView
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()

    // MARK: - Variables
    private var imageViews: [UIImageView] = []
    private let imageNames = ["church", "dosol", "gwanhanru", "hanok"]

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        addSubview(pageControl)
        setupImageViews()
        scrollView.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let padding: CGFloat = 0
        let bottomPadding: CGFloat = 20 // 테이블뷰 헤더 아래 여백
        scrollView.frame = bounds.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding + bottomPadding, right: padding))

        pageControl.frame = CGRect(x: 0, y: bounds.height - 70, width: bounds.width, height: 30)

        for (index, imageView) in imageViews.enumerated() {
            imageView.frame = CGRect(x: CGFloat(index) * bounds.width, y: 0, width: bounds.width, height: bounds.height)
        }

        scrollView.contentSize = CGSize(width: bounds.width * CGFloat(imageViews.count), height: bounds.height)
        scrollView.setContentOffset(CGPoint(x: bounds.width, y: 0), animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    private func setupImageViews() {
        // 첫 번째 및 마지막 이미지 추가
        let extendedImageNames = [imageNames.last!] + imageNames + [imageNames.first!]
        pageControl.numberOfPages = imageNames.count

        for imageName in extendedImageNames {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: imageName)
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
    }
}

// MARK: - Extensions
extension HeroHeaderUIView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let pageIndex = round(scrollView.contentOffset.x / pageWidth)
        pageControl.currentPage = Int(pageIndex) - 1 // 실제 페이지 수는 `-1` 보정

        if scrollView.contentOffset.x <= 0 {
            // 첫 번째 페이지로 돌아가면 마지막 페이지로 이동
            scrollView.setContentOffset(CGPoint(x: pageWidth * CGFloat(imageViews.count - 2), y: 0), animated: false)
        } else if scrollView.contentOffset.x >= scrollView.contentSize.width - pageWidth {
            // 마지막 페이지로 돌아가면 첫 번째 페이지로 이동
            scrollView.setContentOffset(CGPoint(x: pageWidth, y: 0), animated: false)
        }
    }
}
