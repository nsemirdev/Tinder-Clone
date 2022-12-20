//
//  BottomStackView.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class BottomStackView: UIStackView {

    // MARK: - Properties
    
    let buttons = [#imageLiteral(resourceName: "03_1.png"), #imageLiteral(resourceName: "03_2.png"), #imageLiteral(resourceName: "03_3.png"), #imageLiteral(resourceName: "03_4.png"), #imageLiteral(resourceName: "03_5.png")].map { image in
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure() {
        buttons.forEach { addArrangedSubview($0) }
        distribution = .fillEqually
    }
}
