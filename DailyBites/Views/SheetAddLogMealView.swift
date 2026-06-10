import SwiftUI
import SwiftData
import Foundation

struct SheetAddLogMealView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var meals: [Meal]
    
    @State private var mealName: String = ""
    @State private var descriptionMeal: String = ""
    @State private var status: Status = Status.pendente
    @State private var satiety: Satiety = Satiety.satisfeito
    @State private var durationMeal: Int = 0
    @State private var selectedMood: Mood = .neutral
    @State private var imageData: Data? = nil
    @State private var time = Date()
    @State private var date = Date()
    @State private var isFixed: Bool = false
    @State private var auxDuration: String = ""
    @State private var repeatDays: [Int] = []

    let meal: Meal
    
    func addLog(){
        if let todayLog = meal.logs.last(where: { $0.ref!.name == meal.name }){
            todayLog.emotion = selectedMood
            todayLog.status = status
            todayLog.satiety = satiety
            todayLog.descriptionMeal = descriptionMeal
            todayLog.durationMeal = durationMeal
            todayLog.imageData = imageData
            todayLog.ref!.isFixed = isFixed
            
        }
        else{
            let checkMeal = meals.count(where: { $0.name == mealName })
            if checkMeal == 0 {
                meal.name = mealName
                meal.time = time
                meal.isFixed = isFixed
                meal.repeatDays = repeatDays
                modelContext.insert(meal)
            }
            let log = LogMeal(
                ref: meal,
                date: date,
                satiety: satiety,
                imageData: imageData,
                durationMeal: durationMeal,
                status: status,
                descriptionMeal: descriptionMeal,
                emotion: selectedMood
            )
            modelContext.insert(log)
        }
  
        dismiss()
    }
    var body: some View {
        
        NavigationStack {
            
            Form {
                Section {
                    FocusableTextField(placeholder: "Nome da refeição", text: $mealName)
                } header: {
                    SectionLabel(title:"NOME DA REFEIÇÃO", required: true)
                }
                .accessibilityLabel(Text("Digite o nome da sua refeição"))
                .accessibilityHint("Digite o nome da sua refeição")
                .accessibilityIdentifier("Campo de texto de nome da refeição")
                .padding(.top, -10)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .foregroundStyle(.primary)
                
                Section {
                    RepeatMeals(time: $time, isFixed: $isFixed, repeatDays: $repeatDays)
                } header: {
                    SectionLabel(title:"HORÁRIO", required: true)
                }
                .padding(.top, -10)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .foregroundStyle(.primary)
                
                Section {
                    PickerField(placeholder: "Selecione", options: Status.allCases.map(\.title), selected: Binding(get: {status.title}, set: {status = Status.fromTitle($0) ?? .pendente }), defaultValue: Status.pendente.title)
                } header: {
                    SectionLabel(title:"PONTUALIDADE", required: true)
                }
                .accessibilityLabel(Text("Selecione a pontualidade da sua refeição"))
                .accessibilityHint("A pontualidade da sua refeição é importante para as estatísticas")
                .accessibilityIdentifier("Campo de selecionar a pontualidade no horário da sua refeição")
                .padding(.top, -10)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .foregroundStyle(.primary)
                
                Section {
                    FocusableTextField(placeholder: "Digite a duração em minutos", text: $auxDuration)
                    .keyboardType(.numberPad)
                } header: {
                    SectionLabel(title:"TEMPO MÉDIO", required: true)
                }
                .accessibilityLabel(Text("Tempo médio da refeição"))
                .padding(.top, -10)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .foregroundStyle(.primary)
                
                Section {
                    PickerField(placeholder: "Selecione", options: Satiety.allCases.map(\.title), selected: Binding(get: {satiety.title}, set: {satiety = Satiety.fromTitle($0) ?? .satisfeito }), defaultValue: Satiety.satisfeito.title)
                } header: {
                    SectionLabel(title:"SACIEDADE", required: true)
                }
                .accessibilityLabel(Text("Selecione a saciedade da sua refeição"))
                .accessibilityHint("Salva a saciedade da sua refeição para melhorar as suas estatísticas")
                .accessibilityIdentifier("Campo de selecionar a saciedade da sua refeição")
                .padding(.top, -10)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .foregroundStyle(.primary)
                
                Section {
                    EmojiSelector(selectedMood: $selectedMood)
                } header: {
                    SectionLabel(title:"HUMOR APÓS A REFEIÇÃO", required: true)
                }
//                .accessibilityLabel(Text("Selecione o seu humor após a refeição"))
                .padding(.top, -5)
                .padding(.bottom, -5)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .foregroundStyle(.primary)
                
                Section {
                    PhotoContainer(imageData: $imageData)
                } header: {
                    SectionLabel(title:"FOTO", required: false)
                }
                .accessibilityLabel(Text("Tire uma foto com a câmera ou escolha uma imagem da sua galeria"))
                .accessibilityHint("Escolha ou tire uma foto da sua refeição")
                .accessibilityIdentifier("Escolha ou tire uma foto da sua refeição")
                
                Section {
                    FocusableTextFieldDescription(placeholder: "Faça um comentário sobre a sua refeição", text: $descriptionMeal)
                } header: {
                    SectionLabel(title:"DESCRIÇÃO", required: false)
                }
                .accessibilityLabel(Text("Digite um comentário sobre como foi a sua refeição"))
                .accessibilityHint("Digite um comentário sobre como foi a sua refeição")
                .accessibilityIdentifier("Campo de texto de descrição")
                .padding(.top, -10)
                .listRowBackground(Color.clear)
                .font(Font.subheadline.bold())
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.primary)
                
            }
            .accessibilityLabel("Formulário para registrar refeição")
            .scrollContentBackground(.hidden)
            .background(Color(.secondarySystemBackground))
            
            .listSectionSpacing(.compact)
            .navigationTitle(Text("Registre sua refeição"))
            .accessibilityLabel(Text("Formulário de registro de refeição"))
            .accessibilityHint("Digite e salve informações sobre suas refeições para acompanhar os seus hábitos alimentares")
            .accessibilityIdentifier("Formulário de registro de refeição")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .padding()
                            .accessibilityLabel(Text("Cancelar"))
                            .accessibilityHint("Cancela o formulário e volta à tela anterior")
                            .accessibilityIdentifier("toolbarCancelarButton")
                    }
                    
                
                }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark")
                        {
                            meal.name = mealName
                            meal.time = time
                            durationMeal = Int(auxDuration) ?? 0
                            addLog()
                        }
                        .accessibilityLabel("Salvar")
                        .accessibilityHint("Salva as informações do formulário e volta à tela anterior")
                        .accessibilityIdentifier("toolbarSalvarButton")
                        .disabled(status == .pendente)
                        .tint(Color("RoxoDailyBites"))
                    }
                }
        }
        
        
        .toolbar(.hidden, for: .tabBar)
        .scrollDismissesKeyboard(.immediately)
        .onAppear {
            mealName = meal.name
            time = meal.time
            
            isFixed = meal.isFixed
            repeatDays = meal.repeatDays
            let thisMeal = meal.logs.last(where: { $0.ref!.name == meal.name })
            mealName = meal.name
       
            if let imageData = thisMeal?.imageData {
                self.imageData = imageData
            }
            descriptionMeal = thisMeal?.descriptionMeal ?? ""
            status = thisMeal?.status ?? .pendente
            satiety = thisMeal?.satiety ?? .satisfeito
            selectedMood = thisMeal?.emotion ?? .neutral
            durationMeal = thisMeal?.durationMeal ?? 0
            auxDuration = durationMeal == 0 ? "" : String(durationMeal)
                       
            // isFixed = thisMeal?.ref!.isFixed ?? false
            }
        }
    }
