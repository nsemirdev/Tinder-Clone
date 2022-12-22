//
//  RegistrationViewModel.swift
//  Tinder-Clone
//
//  Created by Emir Alkal on 21.12.2022.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()

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
        
        bindableIsFormValid.value = isFormValid
    }
    
    func performRegistration(completion: @escaping (Error?) -> Void) {
        bindableIsRegistering.value = true

        guard let email else { return }
        guard let password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                completion(error)
                self.bindableIsRegistering.value = false
                return
            }
            
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let image = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            
            ref.putData(image) { _, err in
                if let err {
                    completion(err)
                    return
                }
                
                ref.downloadURL { url, error in
                    if let error {
                        completion(error)
                    }
                    
                    self.bindableIsRegistering.value = false
                }
            }
        }
    }
}
