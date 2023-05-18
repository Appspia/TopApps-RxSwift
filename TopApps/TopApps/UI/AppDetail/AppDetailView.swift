//
//  AppDetailView.swift
//  TopApps
//
//  Created by APPSPIA on 2023/05/17.
//

import UIKit
import SnapKit
import Then

class AppDetailView: LayoutView {
    /// Scroll
    private let scrollview = UIScrollView()
    
    /// Main Stack
    private let mainStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.isLayoutMarginsRelativeArrangement = true
    }
    
    /// App Info Stack
    private let appInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 8
    }
    
    /// App Info Center Stack
    private let appInfoCenterStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    /// App Icon
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    /// App Title
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 2
    }
    
    /// App Company
    let companyLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = UIColor.systemGray
    }
    
    /// App Category
    let categoryLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = UIColor.systemGray
    }
    
    /// Get Button
    let getButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor.systemFill
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    /// App description
    let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.numberOfLines = 0
    }
    
    override func load() {
        backgroundColor = .systemBackground
        addSubview(scrollview)
        scrollview.addSubview(mainStackView)
        
        // Main Stack
        mainStackView.addArrangedSubview(appInfoStackView)
        mainStackView.addArrangedSubview(descriptionLabel)
        
        // App Info Stack
        appInfoStackView.addArrangedSubview(iconImageView)
        appInfoStackView.addArrangedSubview(appInfoCenterStack)
        appInfoStackView.addArrangedSubview(getButton)
        
        // App Info Center Stack
        appInfoCenterStack.addArrangedSubview(titleLabel)
        appInfoCenterStack.addArrangedSubview(companyLabel)
        appInfoCenterStack.addArrangedSubview(categoryLabel)
        appInfoCenterStack.setCustomSpacing(2, after: companyLabel)
    }
    
    override func layout() {
        scrollview.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(90)
        }
        
        getButton.setContentHuggingPriority(.required, for: .horizontal)
    }

}
