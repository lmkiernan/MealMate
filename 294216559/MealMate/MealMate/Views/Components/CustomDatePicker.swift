//
//  CustomDatePicker.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}
