//
//  AuthenticationApp.swift
//  Authentication
//
//  Created by Nijen Patel on 08/05/24.
//

import SwiftUI
import Firebase

@main
struct AuthenticationApp: App {

    @StateObject var viewModel = AuthViewModel()

    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
