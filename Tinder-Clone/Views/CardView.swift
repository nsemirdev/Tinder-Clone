//
//  CardView.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: cardViewModel.imageNames.first ?? "")
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { _ in
                let barView = UIView()
                barView.layer.cornerRadius = 3
                barView.backgroundColor = UIColor(white: 0, alpha: 0.1)
                barsStackView.addArrangedSubview(barView)
            }
            
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            setupImageIndexObserver()
        }
    }
    
    
    // MARK: - UI Elements
    
    let imageView           = UIImageView(image: #imageLiteral(resourceName: "lady5c.jpg"))
    let informationLabel    = UILabel()
    let gradientLayer       = CAGradientLayer()
    let barsStackView       = UIStackView()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        imageView.contentMode = .scaleAspectFill
        configureGradientLayer()
        configureLabels()
        configureBarsStackView()
    }
        
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.frame
    }
    
    func configureLabels() {
        addSubview(informationLabel)
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            informationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        informationLabel.textColor = .white
        informationLabel.font = .systemFont(ofSize: 34, weight: .heavy)
        informationLabel.numberOfLines = 0
    }
    
    func configureBarsStackView() {
        addSubview(barsStackView)
        barsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            barsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            barsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            barsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            barsStackView.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        barsStackView.spacing = 4
        barsStackView.axis = .horizontal
        barsStackView.distribution = .fillEqually

        
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let degress: CGFloat = translation.x / 20
        let angle = degress * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let shouldDismissCardRight = gesture.translation(in: nil).x > 100
        let shouldDismissCardLeft = gesture.translation(in: nil).x < -100
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCardRight {
                self.transform = self.transform.translatedBy(x: 1000, y: 400)
            } else if shouldDismissCardLeft {
                self.transform = self.transform.translatedBy(x: -1000, y: 400)
            } else {
                self.transform = .identity
            }
        }) { _ in
            shouldDismissCardLeft || shouldDismissCardRight ? self.removeFromSuperview() : ()
        }
    }
    
    func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { idx, image in
            self.imageView.image = image
            self.barsStackView.arrangedSubviews.forEach { v in
                v.backgroundColor = UIColor(white: 0, alpha: 0.1)
            }
            self.barsStackView.subviews[idx].backgroundColor = .white
        }
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
       
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ view in
                view.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            break
        }
    }
}
