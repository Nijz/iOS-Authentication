//
//  RegistrationView.swift
//  Authentication
//
//  Created by Nijen Patel on 10/05/24.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword =  ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            
            Image("sticker_1")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 220)
                .padding(.vertical, 22)
            
            VStack(spacing: 24){
                InputView(text: $fullName,
                          title: "Full Name",
                          placeholder: "Milk Mocha",
                          isSecureField: false)
                
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
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confir Password",
                              placeholder: "Confirm your password",
                              isSecureField: true)
                    .textInputAutocapitalization(.never)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemGreen))
                        } else {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.systemRed))
                        }
                            
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button(action: {
                
                Task {
                    do {
                        try await viewModel.createUser(withEmail: email,
                                                       fullName: fullName,
                                                       password: password)
                    } catch {
                        print("DEBUG: Error in create account")
                    }
                }
                
            }, label: {
            
                HStack{
                    Text("CREATE ACCOUNT")
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
            .padding(.top, 24)
            
            Spacer()
            Divider()
            
            Button (action: {
                dismiss()
            }, label: {
                HStack(spacing: 3){
                    Text("Don't have an account?")
                    Text("Sign up")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .padding(.top, 10)
                .foregroundStyle(Color(.brown))
            })
        }
    }
}

// MARK: - Auth Form Protocol
extension RegistrationView: AuthenticationFormProtocol {
    var formValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    RegistrationView()
}
