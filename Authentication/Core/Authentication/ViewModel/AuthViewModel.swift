//
//  AuthViewModel.swift
//  Authentication
//
//  Created by Nijen Patel on 10/05/24.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    
    var formValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        
        do {
            
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
            
        } catch {
            print("DEBUG: error while logging in \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, fullName: String, password: String) async throws{
        
        do {
        
            // Attempt to create a new user account using Firebase Authentication
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // If successful, update the userSession property with the authenticated user
            self.userSession = result.user
            
            // Create a User object with the provided data
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            // Encode the User object into a format suitable for Firestore
            let encodedUser = try Firestore.Encoder().encode(user)
            
            // Store the encoded user data in Firestore under the "users" collection
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            await fetchUser()
            
        } catch {
            
            print("DEBUG: Error in create function -> \(error.localizedDescription)")
            
        }
    }
    
    func signOut(){
        do {
            
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("User signed out")
            
        } catch {
            print("DEBUG: error in sign out")
        }
        
    }
    
    func deleteAccount() {
        
//        do {
//            
//            
//            
//        } catch {
//            
//        }
    }
    
    func fetchUser() async {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(currentUser)")
    }
    
}
