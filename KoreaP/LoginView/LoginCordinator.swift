//
//  LoginCordinator.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 18..
//  Copyright © 2018년 swift. All rights reserved.
//


import Foundation
import ILLoginKit

class LoginCoordinator: ILLoginKit.LoginCoordinator {
    
    // MARK: - LoginCoordinator
    
    override func start() {
        super.start()
        configureAppearance()
    }
    
    override func finish() {
        super.finish()
    }
    
    // MARK: - Setup
    
    // Customize LoginKit. All properties have defaults, only set the ones you want.
    func configureAppearance() {
        // Customize the look with background & logo images
        
        // mainLogoImage =
        // secondaryLogoImage =
        
        // Change colors
        tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
        errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)
        
        // Change placeholder & button texts, useful for different marketing style or language.
        loginButtonText = "로그인"
        signupButtonText = "회원가입"
        forgotPasswordButtonText = "Forgot password?"
        recoverPasswordButtonText = "Recover"
        namePlaceholder = "Name"
        emailPlaceholder = "E-Mail"
        passwordPlaceholder = "Password!"
        repeatPasswordPlaceholder = "Confirm password!"
        
    }
    
    // MARK: - Completion Callbacks
    
    // Handle login via your API
    override func login(email: String, password: String) {
        print("Login with: email =\(email) password = \(password)")
    }
    
    // Handle signup via your API
    override func signup(name: String, email: String, password: String) {
        print("Signup with: name = \(name) email =\(email) password = \(password)")
    }
    
    // Handle Facebook login/signup via your API
    override func enterWithFacebook(profile: FacebookProfile) {
        print("Login/Signup via Facebook with: FB profile =\(profile)")
    }
    
    // Handle password recovery via your API
    override func recoverPassword(email: String) {
        print("Recover password with: email =\(email)")
    }
    
}
