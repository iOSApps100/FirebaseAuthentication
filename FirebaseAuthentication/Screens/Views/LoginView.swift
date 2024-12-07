
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // logo
                Image("login_image")
                    .resizable()
                    .scaledToFit()
                //title
                Text("Let's Connect With US!")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer().frame(height: 12)
                
                // textfields
                InputView(placeholder: "Email or phone number", text: $email)
                InputView(placeholder: "Password", isSecureField: true, text: $password)
                
                
                // forgot button
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
                
                // login button
                
                Button {
                    
                } label: {
                    Text("Login")
                }
                .buttonStyle(CapsuleButtonStyle())
                
                
                // bottom view or
                HStack(spacing: 16) {
                    line
                    
                    Text("or")
                        .fontWeight(.semibold)
                    
                    line
                }
                .foregroundStyle(.gray)
                
                // apple
                
                Button {
                    
                } label: {
                    // use label to make text with image
                    Label("Sign up with Apple", systemImage: "apple.logo")
                }
                .buttonStyle(CapsuleButtonStyle(bgColor: .black))

                
                // google
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

                
                // footer
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)// will give default 16 padding from both the ends.
        .padding(.vertical, 8)// will give 8 padding form both the vertical ends.
    }
    
    private var line: some View {
        VStack { Divider().frame(height: 1)}
        }
    
}

#Preview {
    LoginView()
}

// you can use struct to do make custom/reusable button but here we will use modifier.
struct CapsuleButtonStyle: ButtonStyle {
    var bgColor: Color = .teal
    var textColor: Color = .white
    var hasBorder: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor))
            .scaleEffect(configuration.isPressed ? 0.95 : 1 )
            .overlay {
                hasBorder ? Capsule().stroke(.gray, lineWidth: 1) : nil
            }
    }
    
    
}
