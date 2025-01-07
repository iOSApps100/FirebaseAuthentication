//
//  Router.swift
//  FirebaseAuthentication
//
//  Created by Vivek  Garg on 07/01/25.
//

import SwiftUI

final class Router: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    // need to make it hashable because it will check it(screens) uniqueness, and codable when you get and store value you need to encode and decode it that why 'codable'.
    enum AuthFlow: Hashable, Codable {
        
        case login
        case createAccount
        case profile
        case forgotPassword
        case emailSent
    }
    
    func navigate(to destination: AuthFlow) {
        
        navPath.append(destination)
    }
    
    func navigateBack() {
        
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        
        navPath.removeLast(navPath.count)
    }
}
