//
//  RegistrationViewModel.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 21.12.2022.
//

import UIKit

class RegistrationViewModel {
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false &&
                            email?.isEmpty == false &&
                            password?.isEmpty == false
        
        
        isFormValidObserver?(isFormValid)
    }
    
    var isFormValidObserver: ((Bool) -> Void)?
    
}
