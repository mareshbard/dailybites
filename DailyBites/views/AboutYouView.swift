import SwiftUI
import SwiftData

struct AboutYouView: View {

    @AppStorage("numberOfMeals") private var numberOfMeals: Int = 1
//    @State private var Meal: [Meal] = [Meal(mealName: "", date: .now, time: .now, imageData: nil, durationMeal: 0, status: .pendente, descriptionMeal: "", emotion: .normal)]
    @State private var selectedNumber = 1
    let range = 1...10
    @AppStorage("username") var username: String = ""
    @Environment(\.modelContext)
    private var modelContext
    @AppStorage("firstUse") var firstUse: Bool = true
    @State private var username1: String = ""
    @State private var isActive: Bool = false
    @State private var number: Numbers = Numbers.um
    
    enum Numbers: String, CaseIterable {
        case um
        case dois
        case tres
        case quatro
        case cinco
        case seis
        case sete
        case oito
        case nove
        case dez
        
        var id: Self { self }
        
        var range: String{
            switch self {
            case .um: return "1"
            case .dois: return "2"
            case .tres: return "3"
            case .quatro: return "4"
            case .cinco: return "5"
            case .seis: return "6"
            case .sete: return "7"
            case .oito: return "8"
            case .nove: return "9"
            case .dez: return "10"
            }
        }
        
        static func fromTitle (_ range: String) -> Numbers? {
            Numbers.allCases.first{$0.range == range}
        }
    }
    
    var body: some View {
   
        NavigationStack{
            ScrollView{
          
                Image("AppleAboutYou")
                    .padding(55)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity)
                    .background(Color("RoxoStroke"))
                    .clipShape(RoundedRectangle(cornerRadius: 35))
                    .ignoresSafeArea()
                    .accessibilityHidden(isActive)
                
                
                    VStack {
                        
                        VStack{

                            Text("Quero te conhecer")
                                .font(Font.largeTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 15)
                            
                            Text("Como gostaria de ser chamado?")
                                .font(Font.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("Digite seu nome", text: $username1)
                                .font(Font.body)
                                .textFieldStyle(OutlinedTextFieldStyle())
                              //  .accessibilityLabel("Campo de texto, coloque seu nome completo")
                            //    .accessibilityLabel(username1.isEmpty ? "Campo de texto vazio" : username1)

                            Text("Quantas refeições você faz ao dia?")
                                .font(Font.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                       
                                
                            PickerField(placeholder: "Quantidade", options: Numbers.allCases.map(\.range), selected: Binding(get: {number.range}, set: {number = Numbers.fromTitle($0) ?? .um }), defaultValue: Numbers.um.range)
                            .font(Font.body)
                            .padding(20)
                            .overlay {
                                
                                RoundedRectangle( cornerRadius: 12)
                                    .fill(.clear)
                                    .stroke(Color("RoxoStroke"), style: StrokeStyle(lineWidth: 0.5))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            //                    meals = self.meals
                            numberOfMeals = Int(number.range) ?? 1
                            self.isActive = true
                        } label: {
                            Label("Próximo", systemImage: "")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        //        .buttonSizing(.flexible)
                        .font(Font.title3)
                        .controlSize(.large)
                        .tint(Color("RoxoAcao"))
                        .foregroundColor(Color(.white))
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        
                        NavigationLink(destination: PreferencesView(username1: username1, numberOfMeals: numberOfMeals), isActive: $isActive){
                            
                        }
                        
                        
                        
                    }
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .padding(.horizontal, 24)
                
            }

            .ignoresSafeArea()

        }
        .scrollDismissesKeyboard(.immediately)
        


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
