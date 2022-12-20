//
//  CardView.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class CardView: UIView {

    let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c.jpg"))
    
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
    }
    
    func setupGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }
    
    fileprivate func hangleChanged(_ gesture: UIPanGestureRecognizer) {
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
            self.transform = .identity
        }
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            hangleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            break
        }
    }
}
