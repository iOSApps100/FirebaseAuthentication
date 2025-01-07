//
//  ProfileView.swift
//  FirebaseAuthentication
//
//  Created by Vivek  Garg on 14/12/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router // will take value from main path 'FirebaseAuthenticationApp'
    
    var body: some View {
        
        if let user = authViewModel.currentUser {
            List {
                // Section 1
                Section {
                    HStack(spacing: 16) {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 70, height: 70)
                            .background(Color(.lightGray))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text(user.email)
                        }
                    }
                }
                
                // Section 2
                Section("Accounts") {
                    Button {
                        authViewModel.signOut()
                    }
                label: {
                    Label {
                        Text("Sign Out")
                        
                            .foregroundStyle(.black)
                    } icon: {
                        Image(systemName: "arrow.left.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                    Button {
                        Task {
                            await authViewModel.deleteAccount()
                        }
                    }
                label: {
                    Label {
                        Text("Delete Account")
                            .foregroundStyle(.black)
                    } icon: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                }
                }
            }
        } else {
            ProgressView("Please wait...")
        }
        
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
