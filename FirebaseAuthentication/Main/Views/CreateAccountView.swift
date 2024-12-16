//
//  CreateAccountView.swift
//  FirebaseAuthentication
//
//  Created by Vivek  Garg on 10/12/24.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    // @StateObject private var authViewModel = AuthViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode // for pop view controller of createaccountview
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please complete all information to create an account")
                .font(.headline).fontWeight(.medium)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
           // Spacer()
            
            InputView(placeholder: "Email or Phone number", text: $email)
            InputView(placeholder: "Full Name", text: $fullName)
            InputView(placeholder: "Password", isSecureField: true, text: $password)
            
            ZStack(alignment: .trailing) {
                InputView(placeholder: "Confirm Password", isSecureField: true, text: $confirmPassword)
                Spacer()
                if !password.isEmpty && !confirmPassword.isEmpty {
                    Image(systemName: "\(isValidPassword ? "checkmark" : "xmark").circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundColor(isValidPassword ? Color(.systemGreen) : Color(.systemRed))
                    
                }
            }
            
            Spacer()
            
            Button {
                Task {
                    await authViewModel.createUser(email: email, fullName: fullName, password: password)
                    
                    if !authViewModel.isError {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } label: {
                Text("Create Account")
            }
            .buttonStyle(CapsuleButtonStyle())
            
        }
        .navigationTitle("Set up your account")
        .toolbarRole(.editor)// will remove navigation 'back' title.
        .padding()
    }
    
    var isValidPassword: Bool {
        confirmPassword == password
    }
}

#Preview {
    CreateAccountView()
}
