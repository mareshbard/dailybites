import SwiftUI

struct TextInfo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("PlusJakartaSans-Regular", size: 18.0))
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("mealBackground"))
            .cornerRadius(10)
            
    }
}

struct TagText: ViewModifier {
    let log: LogMeal
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(log.color)
            .foregroundStyle(log.fontColor)
            .cornerRadius(52)
            .font(Font.custom("PlusJakartaSans-Medium", size: 15))
    }
}
