import SwiftUI
struct FocusableTextField: View {
    let placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(Font.body)
            .padding(10)
            .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
                    .stroke(isFocused ? Color("RoxoDailyBites") : Color.clear, lineWidth: 2)
            )
            .focused($isFocused)
    }
}
struct FocusableTextFieldDescription: View {
    let placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(Font.body)
            .padding(10)
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .topLeading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
                    .stroke(isFocused ? Color("RoxoDailyBites") : Color.clear, lineWidth: 2)
                
            )
            .focused($isFocused)
        
    }
}
struct PickerField: View {
    let placeholder: String
    let options: [String]
    @Binding var selected: String
    let defaultValue: String
    @State private var isFocused = false
    let feedback = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option) {
                    selected = option
                    withAnimation { isFocused = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation { isFocused = false }
                    }
                    feedback.prepare()
                    feedback.impactOccurred()
                }

            }
        } label: {
            HStack {
                Text(selected == defaultValue ? placeholder : selected)
                    .foregroundStyle(
                        selected == defaultValue
                        ? Color(.tertiaryLabel)
                        : Color(.label)
                    )
                Spacer()
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundStyle(Color(.tertiaryLabel))
                    .font(.caption)
            }
            .padding(12)
            .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isFocused ? Color.clear : Color.clear, lineWidth: 2)
                    )
            )
            .contentShape(Rectangle())
            
        }
        .buttonStyle(.plain)
        
    }
}
