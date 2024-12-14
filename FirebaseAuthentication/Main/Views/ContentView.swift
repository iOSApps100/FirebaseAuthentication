//
//  ContentView.swift
//  FirebaseAuthentication
//
//  Created by Vivek  Garg on 06/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else {
                ProfileView()
            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
