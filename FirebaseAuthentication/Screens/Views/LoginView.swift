
import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // logo
                    logo
                    //title
                    titleView
                    
                    Spacer().frame(height: 12)
                    
                    // textfields
                    InputView(placeholder: "Email or phone number", text: $email)
                    InputView(placeholder: "Password", isSecureField: true, text: $password)
                    
                    
                    // forgot button
                    forgotButton
                    // login button
                    loginButton
                    
                    
                    Spacer()
                    // bottom view or
                    bottomView
                    
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal)// will give default 16 padding from both the ends.
            .padding(.vertical, 8)// will give 8 padding form both the vertical ends.
            
        }
    }
    
    private var line: some View {
        VStack { Divider().frame(height: 1)}
        }
    
    private var logo: some View {
        Image("login_image")
            .resizable()
            .scaledToFit()
    }
    
    private var titleView: some View {
        Text("Let's Connect With US!")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    private var forgotButton: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Text("Forgot Password?")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
    
    private var loginButton: some View {
        Button {
            Task {
                await authViewModel.login(email: email, password: password)
            }
        } label: {
            Text("Login")
        }
        .buttonStyle(CapsuleButtonStyle())
    }
    
    private var lineorView: some View {
        HStack(spacing: 16) {
            line
            
            Text("or")
                .fontWeight(.semibold)
            
            line
        }
        .foregroundStyle(.gray)
    }
    
    private var bottomView: some View {
        VStack (spacing: 16) {
            lineorView
            appleButton
            googleButton
            fotterView
        }
    }
    
    private var appleButton: some View {
        Button {
            
        } label: {
            // use label to make text with image
            Label("Sign up with Apple", systemImage: "apple.logo")
        }
        .buttonStyle(CapsuleButtonStyle(bgColor: .black))
    }
    
    private var googleButton: some View {
        Button {
            
        } label: {
            HStack {
                Image("google")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("Sign up with Google")
            }
        }
        .buttonStyle(CapsuleButtonStyle(bgColor: .clear, textColor: .black, hasBorder: true))
    }
    
    private var fotterView: some View {
        NavigationLink {
            // When using navigationLink you need to embed it in navigationStack then it will work. Later we will see better approach.
            CreateAccountView()
        } label: {
            HStack {
                Text("Don't have an account?")
                    .foregroundStyle(.black)
                Text("Sign Up")
                    .foregroundStyle(.teal)
            }
        }
        .fontWeight(.medium)
    }
}

#Preview {
    LoginView()
}


