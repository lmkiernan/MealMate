//
//  CustomTextField.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.words)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
