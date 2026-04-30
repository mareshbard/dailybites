import SwiftUI
import SwiftData

struct AboutYouView: View {

    @State private var numberOfMeals: Int = 1
    @State private var meals: [Meal] = [Meal(mealName: "", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pendente, descriptionMeal: "")]
    @State private var selectedNumber = 1
    let range = 1...10
    @AppStorage("username") var username: String = ""
    @Environment(\.modelContext)
    private var modelContext
    @State private var username1: String = ""
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack{
            
            VStack {
                VStack{
                    Image("AppleAboutYou")
                        .padding(25)
                        .font(.largeTitle)
                    Text("Sobre você")
                        .font(.largeTitle)
                        .padding(15)
                    
                    Text("Qual é o seu nome?")
                        .font(Font.title2)
                        .frame(maxWidth: .infinity, maxHeight: 15, alignment: .leading)
                    
                    TextField("Nome", text: $username1)
                        .font(Font.body)
                        .textFieldStyle(OutlinedTextFieldStyle())
                    
                    Text("Quantas refeições você faz por dia?")
                        .font(Font.title2)
                        .frame(maxWidth: .infinity, maxHeight: 15, alignment: .leading)
                    
                    HStack{
                        Text("Escolha a quantidade")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.body)
                            .foregroundStyle(.tertiary)
                        Picker("Escolha a quantidade", selection: $numberOfMeals){
                            ForEach(range, id: \.self) {number in
                                Text("\(number)").tag(number)
                            }
//                            .onChange(of: numberOfMeals) { newValue in
//                                createEmptyMeals()
//                            }
                        }
                        .tint(Color.red)
                    }
                    .padding(20)
                    .overlay {
                        
                        RoundedRectangle( cornerRadius: 12)
                            .fill(.clear)
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                    }
                }
                Button("Próximo", action: {
                    meals = self.meals
                    self.isActive = true
                })
                
                               .buttonStyle(.borderedProminent)
                               .buttonSizing(.flexible)
                               .font(Font.title3)
                               .controlSize(.large)
                               .tint(.red)
                               .foregroundColor(Color(.white))
                Spacer()
                NavigationLink(destination: PreferencesView(username1: username1, numberOfMeals: numberOfMeals), isActive: $isActive){
                   
                }
 
                
            }
        }
        .padding(.horizontal, 24)

    }

    
//    func createEmptyMeals() {
//        var tempMeals: [Meal] = []
//        for  _ in 0..<numberOfMeals {
//            tempMeals.append(Meal(mealName: "", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pendente, descriptionMeal: ""))
//        }
//        meals = tempMeals
//    }
        
    }


#Preview {
    AboutYouView()
}
//teste
