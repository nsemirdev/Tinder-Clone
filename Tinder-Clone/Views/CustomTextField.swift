//
//  CustomTextField.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 21.12.2022.
//

import UIKit

class CustomTextField: UITextField {
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 25
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 16, dy: 0)
    }
        
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 16, dy: 0)
    }
        
    override var intrinsicContentSize: CGSize {
       .init(width: 0, height: 50)
    }
}
