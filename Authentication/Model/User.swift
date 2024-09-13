//
//  User.swift
//  Authentication
//
//  Created by Nijen Patel on 10/05/24.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        // Create a PersonNameComponentsFormatter instance
        let formatter = PersonNameComponentsFormatter()
        
        // Try to extract name components from the full name string
        if let components = formatter.personNameComponents(from: fullName){
            
            // Set the style of the formatter to abbreviated
            formatter.style = .abbreviated
            
            // Use the formatter to generate abbreviated initials from the components
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Virat Kohli", email: "viratkohli18@gmail.com")
}
