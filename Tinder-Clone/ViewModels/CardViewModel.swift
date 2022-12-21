//
//  CardViewModel.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 20.12.2022.
//

import UIKit

class CardViewModel {
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    private var imageIndex = 0 {
        didSet {
            let image = UIImage(named: imageNames[imageIndex])
            imageIndexObserver?(imageIndex, image)
        }
    }
    
    var imageIndexObserver: ((Int, UIImage?) -> Void)?
    
    func advanceToNextPhoto() {
        if imageIndex < imageNames.count - 1 {
            imageIndex += 1
        }
    }
    
    func goToPreviousPhoto() {
        if imageIndex > 0 {
            imageIndex -= 1
        }
    }
}
