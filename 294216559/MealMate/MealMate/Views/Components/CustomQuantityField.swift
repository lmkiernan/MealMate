//
//  CustomQuantityField.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct CustomQuantityField: View {
    @Binding var quantity: String
    @Binding var unit: String
    
    let units = ["unit", "g", "kg", "oz", "lb", "ml", "L", "cup", "pint", "quart", "gallon", "carton", "tbsp", "tsp", "bag", "box", "case", "bottle", "jar", "can", "bag", "stick", "loaf", "slice", "piece", "bar", "head", "clove"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Quantity")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            HStack {
                HStack {
                    Image(systemName: "number")
                        .foregroundColor(.gray)
                        .frame(width: 24)
                    
                    TextField("Amount", text: $quantity)
                        .keyboardType(.decimalPad)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                Menu {
                    Picker("Unit", selection: $unit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit).tag(unit)
                        }
                    }
                } label: {
                    Text(unit)
                        .padding(10)
                        .frame(minWidth: 60)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
        }
    }
}
