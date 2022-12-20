//
//  ViewController.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    let users = [
        User(name: "Kelly", age: 23, profession: "Musij DJ", imageName: "lady5c"),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")
    ]
    
    // MARK: - UI Elements
    
    let mainStackView   = MainStackView()
    let topStackView    = TopStackView()
    let bottomStackView = BottomStackView()
    let middleView      = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Methods
    
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(mainStackView)
        
        mainStackView.setSubviews([topStackView, middleView, bottomStackView])
        mainStackView.bringSubviewToFront(middleView)
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        middleView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        configureCard()
    }
    
    func configureCard() {
        users.forEach { user in
            let cardView = CardView()
            cardView.user = user
            cardView.imageView.image = UIImage(named: user.imageName)
            middleView.addSubview(cardView)

            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
                cardView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
                cardView.topAnchor.constraint(equalTo: middleView.topAnchor),
                cardView.bottomAnchor.constraint(equalTo: middleView.bottomAnchor)
            ])
        }
    }
}
