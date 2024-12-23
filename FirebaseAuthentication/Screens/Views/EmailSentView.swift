//
//  EmailSentView.swift
//  FirebaseAuthentication
//
//  Created by Vivek  Garg on 23/12/24.
//

import SwiftUI

struct EmailSentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(.teal)
            
            VStack(spacing: 8) {
                Text("Check your email")
                    .font(.largeTitle.bold())
                Text("We have sent a password recover instructions to your email.")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            
            Button {
                
            } label: {
                Text("Skip, I'll confirm later.")
            }
            .buttonStyle(CapsuleButtonStyle())
            
            Spacer()
            
            Button {
                dismiss() // See we come to this screen using navigationDestination(isPresented: ...) so this is the way to dismiss this screen. And one way to dismiss when is come from navigationLink() you need to do this @Environment(\.presentationMode) var presentationMode and presentationMode.wrappedValue.dismiss()
            } label: {
                (Text("Did not receive the email? Check your spam filter, or ")
                    .foregroundColor(.gray) +
                Text("try another email address")
                    .foregroundStyle(.teal))
            }


        }
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    EmailSentView()
}
