//
//  LoginView.swift
//  Authentication
//
//  Created by Nijen Patel on 08/05/24.
//

import SwiftUI
import UserNotifications

struct LoginView: View {
   
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            
            VStack{
                // image
                Image("sticker_8")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 220)
                    .padding(.vertical, 22)
                
                // form fields
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "milkmocha@gmail.com",
                              isSecureField: false)
                    .textInputAutocapitalization(.never)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    .textInputAutocapitalization(.never)
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                NavigationLink{
                    Text("Forget password")
                } label: {
                    Text("Forget Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.black))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                // signup btn
                Button(action: {
                    
                    Task {
                        
                        do {
                            try await viewModel.signIn(withEmail: email,
                                                       password: password)
                        } catch {
                            print("DEBUG: Error occured while logging in")
                        }
                    }
                    
                }, label: {
                    
                    HStack{
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                        
                    }
                    .foregroundStyle(Color(.white))
                    .frame(width: UIScreen.main.bounds.width - 32, height: 42)
                })
                .background(Color(.systemBrown))
                .disabled(!formValid)
                .opacity(formValid ? 1.0 : 0.5)
                .clipShape(RoundedRectangle(cornerRadius: 10))


                Spacer()
                Divider()
                
                // sign in btn
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    .padding(.top)
                    .foregroundStyle(Color(.brown))
                }
            }
            .navigationTitle("Milk Mocha")
        }
        
    }
}

// MARK: - Auth Form Protocol 
extension LoginView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
