
import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    @State private var isEmailSent = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Reset Password")
                    .font(.largeTitle)
                Text("Enter the email associated with your account and we'll send an email with instructions to reset your password.")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 32)
            InputView(placeholder: "Enter your email", text: $email)
                .padding(.bottom, 16)
            
            Button {
                Task {
                    await authViewModel.resetPassword(by:email)
                    if !authViewModel.isError {
                        //isEmailSent = true
                        router.navigate(to: .emailSent) // better navigation approach
                    }
                }
                //
            } label: {
                Text("Send Instructions")
            }
            .buttonStyle(CapsuleButtonStyle())
            
            
            Spacer()
            
        }
        .padding()
        .toolbarRole(.editor) // it is for remove back navigation title only it will show back icon.
        .onAppear {
            // when coming back to this screen you need to empty this textfield.
            email = ""
        }
    }
}

#Preview {
    ForgotPasswordView()
}
