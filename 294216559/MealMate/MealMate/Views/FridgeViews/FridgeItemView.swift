//
//  FridgeItemView.swift
//  MealMate
//
//  Created by Caroline Begg on 12/3/24.
//

import SwiftUI

struct FridgeItemView: View {
    @ObservedObject var ingredient: Ingredient
    private let itemWidth = (UIScreen.main.bounds.width - 48) / 2 // 48 accounts for padding and spacing
    private let itemHeight: CGFloat = 180
    
    var body: some View {
        VStack(spacing: 8) {
            Text(iconForIngredient(ingredient.name ?? ""))
                .font(.system(size: 50))
            
            Text(ingredient.name ?? "Unknown")
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text(formattedQuantity(ingredient.quantity) + " " + (ingredient.unit ?? ""))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let expirationDate = ingredient.expirationDate {
                Text(expirationDate, style: .date)
                    .font(.caption)
                    .foregroundColor(isExpiringSoon(date: expirationDate) ? .orange : .secondary)
            }
        }
        .padding()
        .frame(width: itemWidth, height: itemHeight)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
    
    private func isExpiringSoon(date: Date) -> Bool {
        let days = Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0
        return days <= 3 && days >= 0
    }
    
    private func formattedQuantity(_ quantity: Double) -> String {
        if quantity.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", quantity)
        } else {
            return String(format: "%.2f", quantity)
        }
    }
}

func iconForIngredient(_ name: String) -> String {
    let lowercasedName = name.lowercased()
    
    switch lowercasedName {
    case let name where name.contains("milk"):
        return "🥛"
    case let name where name.contains("cheese"):
        return "🧀"
    case let name where name.contains("egg"):
        return "🥚"
    case let name where name.contains("butter"):
        return "🧈"
    case let name where name.contains("meat") || name.contains("chicken"):
        return "🍗"
    case let name where name.contains("fish") || name.contains("salmon") || name.contains("tuna"):
        return "🐟"
    case let name where name.contains("apple"):
        return "🍎"
    case let name where name.contains("banana"):
        return "🍌"
    case let name where name.contains("carrot"):
        return "🥕"
    case let name where name.contains("lettuce") || name.contains("spinach") || name.contains("kale"):
        return "🥬"
    case let name where name.contains("tomato"):
        return "🍅"
    case let name where name.contains("potato"):
        return "🥔"
    case let name where name.contains("pepper") || name.contains("chili"):
        return "🌶️"
    case let name where name.contains("grape"):
        return "🍇"
    case let name where name.contains("orange"):
        return "🍊"
    case let name where name.contains("lemon") || name.contains("lime"):
        return "🍋"
    case let name where name.contains("strawberry"):
        return "🍓"
    case let name where name.contains("blueberry") || name.contains("berry"):
        return "🫐"
    case let name where name.contains("watermelon"):
        return "🍉"
    case let name where name.contains("pineapple"):
        return "🍍"
    case let name where name.contains("peach"):
        return "🍑"
    case let name where name.contains("coconut"):
        return "🥥"
    case let name where name.contains("bread"):
        return "🍞"
    case let name where name.contains("rice"):
        return "🍚"
    case let name where name.contains("pasta") || name.contains("spaghetti") || name.contains("noodle"):
        return "🍝"
    case let name where name.contains("burger"):
        return "🍔"
    case let name where name.contains("pizza"):
        return "🍕"
    case let name where name.contains("steak") || name.contains("beef"):
        return "🥩"
    case let name where name.contains("soup"):
        return "🍲"
    case let name where name.contains("cake"):
        return "🍰"
    case let name where name.contains("cookie"):
        return "🍪"
    case let name where name.contains("ice cream") || name.contains("gelato"):
        return "🍨"
    case let name where name.contains("chocolate"):
        return "🍫"
    case let name where name.contains("coffee") || name.contains("espresso"):
        return "☕"
    case let name where name.contains("tea"):
        return "🍵"
    case let name where name.contains("juice"):
        return "🧃"
    case let name where name.contains("wine"):
        return "🍷"
    case let name where name.contains("beer"):
        return "🍺"
    case let name where name.contains("water"):
        return "💧"
    case let name where name.contains("soda") || name.contains("cola"):
        return "🥤"
    case let name where name.contains("popcorn"):
        return "🍿"
    case let name where name.contains("corn"):
        return "🌽"
    case let name where name.contains("mushroom"):
        return "🍄"
    case let name where name.contains("shrimp") || name.contains("prawn"):
        return "🍤"
    case let name where name.contains("bacon"):
        return "🥓"
    case let name where name.contains("honey"):
        return "🍯"
    case let name where name.contains("avocado"):
        return "🥑"
    default:
        return "🥘"
    }
}
