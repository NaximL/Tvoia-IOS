import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            
            
            LinearGradient(
                colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                VStack(spacing: 16) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                    
                    Text("Welcome")
                        .font(.system(size: 36, weight: .bold))
                    
                    Text("Sign in to continue")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                }
                
                
                 
                    if #available(iOS 26.0, *) {
                        fields
                            .padding(24)

//                            .clipShape(RoundedRectangle(cornerRadius: 28))
//                            .glassEffect(.regular)
            
                            
                    } else {
                        fields
                            .padding(28)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 28))
               
                    }
                
                
                if #available(iOS 26.0, *) {
                    Button {
                        print("Login tap")
                    } label: {
                        Text("Log In")
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.glass)
                    .padding(.horizontal)
                } else {
                    Button {
                        print("Login tap")
                    } label: {
                        Text("Log In")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(.blue.gradient)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 5, y: 3)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    

    private var fields: some View {
        VStack {
            
            
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            
            SecureField("Password", text: $password)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        
    }
}

#Preview {
    LoginView()
}
