//
//  ButtonView.swift
//  Authentication
//
//  Created by Nijen Patel on 10/05/24.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    
    let btnText: String
    
    var body: some View {
        
        Button(action: {
            
            print("Performing Action")
            
        }, label: {
        
            HStack{
                Text(btnText)
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundStyle(Color(.white))
            .frame(width: UIScreen.main.bounds.width - 32, height: 42)
        })
        .background(Color(.systemBrown))
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}

#Preview {
    ButtonView(btnText: "Login")
}
