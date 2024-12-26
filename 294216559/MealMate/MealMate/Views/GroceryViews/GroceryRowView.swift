//
//  GroceryRowView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI
import CoreData

struct GroceryRowView: View {
    @ObservedObject var viewModel: GroceryRowViewModel

    var body: some View {
        HStack {
            Button(action: {
                viewModel.toggleIsChecked()
            }) {
                Image(systemName: viewModel.grocery.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(viewModel.grocery.isChecked ? .blue : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.grocery.name ?? "Unnamed")
                    .strikethrough(viewModel.grocery.isChecked, color: .gray)
                    .foregroundColor(viewModel.grocery.isChecked ? .gray : .primary)
                    .font(.headline)

                HStack {
                    Text("\(String(format: "%.1f", viewModel.grocery.quantity)) \(viewModel.grocery.unit ?? "unit")")
                        .foregroundColor(.secondary)
                        .font(.subheadline)

                    if let expirationDate = viewModel.grocery.expirationDate {
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(expirationDate, style: .date)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
    }
}
