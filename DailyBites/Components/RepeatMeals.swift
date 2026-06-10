import Foundation
import SwiftUI

struct RepeatMeals: View {
    @Binding var time: Date
    @Binding var isFixed: Bool
    @Binding var repeatDays: [Int]
    let feedback = UIImpactFeedbackGenerator(style: .soft)
    let days = [(letra: "D", dia: "Domingo"), (letra: "S", dia: "Segunda"),(letra: "T", dia: "Terça"),(letra: "Q", dia: "Quarta"), (letra: "Q", dia: "Quinta"), (letra: "S", dia: "Sexta"), (letra: "S", dia: "Sábado")]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Repetir")
                    .foregroundStyle(.tertiary)
                Spacer()
                Toggle("", isOn: $isFixed)
                    .tint(Color("RoxoDailyBites"))
                    .labelsHidden()
                Text("às")
                    .foregroundStyle(.tertiary)
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .tint(Color("RoxoDailyBites"))
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.horizontal, 7)
            Divider()
            

            HStack(spacing: 5) {
                ForEach(0..<7, id: \.self) { index in
                    Button {
                        if isFixed {
                            if repeatDays.contains(index) {
                                repeatDays.removeAll { $0 == index }
                            } else {
                                repeatDays.append(index)
                                
                            }
                        }
                        feedback.prepare()
                        feedback.impactOccurred()
                    } label: {
                        Text(days[index].letra)
                            .font(.subheadline.bold())
                            .foregroundStyle(
                                repeatDays.contains(index) && isFixed
                                    ? AnyShapeStyle(Color.white)
                                    : isFixed
                                        ? AnyShapeStyle(Color.primary)
                                : AnyShapeStyle(Color.secondary)
                            )
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(
                                        repeatDays.contains(index) && isFixed
                                            ? Color("RoxoDailyBites")
                                            : Color(.systemGray5)
                                    )
                            )
                            
                    }
                    .accessibilityLabel(Text("\(days[index].dia) \(repeatDays.contains(index) ? "selecionado" : "desselecionado")"))
                    .accessibilityHidden(isFixed ? false : true)
                    .buttonStyle(.plain)
                    .disabled(!isFixed)
                    .animation(.easeInOut, value: isFixed)
                }
            }
            .frame(maxWidth: .infinity)
            
            
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
        )
    }
}

#Preview {
    RepeatMeals(time: .constant(Date()), isFixed: .constant(true), repeatDays: .constant([1, 3, 5]))
}
