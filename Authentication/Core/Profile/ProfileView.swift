//
//  ProfileView.swift
//  Authentication
//
//  Created by Nijen Patel on 10/05/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .foregroundStyle(Color(.white))
                            .background(Color(.systemBrown))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(Color(.gray))
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingRowView(imageName: "gear",
                                       title: "Version",
                                       tintColor: Color(.systemGray))
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(Color(.systemGray))
                    }
                }
                
                Section("Account") {
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        SettingRowView(imageName: "nosign.app.fill",
                                       title: "Sign out",
                                       tintColor: Color(.red))
                    })
                    
                    Button(action: {
                       
                    }, label: {
                        SettingRowView(imageName: "xmark.circle.fill",
                                       title: "Delete Account",
                                       tintColor: Color(.red))
                    })
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
