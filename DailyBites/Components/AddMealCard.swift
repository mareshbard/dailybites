import SwiftUI
import SwiftData

struct AddMealCardView: View {
    @State var mealName: String = ""
    @State var time: Date = Date()
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 10
    
    var meal: Meal
    
    var body: some View {
        
        VStack(alignment: .trailing){
            Image(decorative: "purple-pattern")
                .resizable()
                .scaledToFit()
            HStack(alignment: .top, spacing: 15) {
                //pra poder atualizar o objeto do sd em tempo real
                @Bindable var meal = meal
                
                
                VStack(alignment: .center, spacing: 10){
                    
                    Section("Nome da refeição"){
                        
                        TextField("Digite o nome da refeição", text: $meal.name)
                            .font(Font.body)
                          //  .padding(.leading, 10)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 10)
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(100)
                            .padding(.bottom, 13)
                            .multilineTextAlignment(.center)
                           
                    }
                    .accessibilitySortPriority(2)
                 //   .frame(alignment: .leading)
                    .font(Font.custom("PlusJakartaSans-Semibold", size: 18))
                }
                Spacer()
                VStack(alignment: .center, spacing: 10){
                    Section("Horário"){

                        DatePicker("Selecione o horário", selection: $meal.time, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .accessibilitySortPriority(2)
                            .tint(Color("VermelhoDailyBites"))
                            .accessibilityElement(children: .ignore)
                            .accessibilityLabel(Text("Selecione o horário"))
                        // perguntar se devo deixar "time picker" e se é traduzido
                    }
                    .accessibilitySortPriority(1)
                    .frame(alignment: .leading)
                    .font(Font.custom("PlusJakartaSans-Semibold", size: 18))
                }
            }
            .accessibilityElement(children: .contain)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
            // .padding(scaledPadding)
        }
        
        .overlay {
            
            RoundedRectangle( cornerRadius: 12)
            
                .fill(.clear)
                .stroke(Color.roxoStroke, style: StrokeStyle(lineWidth: 1.5))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        //.padding()
    }
}

#Preview {
    let meal1 = Meal(name: "Meal 1", logs: [], time: .now, isFixed: false)
    let meal2 = Meal(name: "Meal 2", logs: [], time: .now, isFixed: false)
    AddMealCardView(meal: meal1)
}
