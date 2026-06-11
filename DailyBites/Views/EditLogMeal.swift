import SwiftUI
import SwiftData
import Foundation

struct EditLogMeal: View {
    

    
    @Environment(\.dismiss) var dismiss
    
    @State private var mealName: String = ""
    @State private var descriptionMeal: String = ""
    @State private var status: Status = Status.pendente
    @State private var durationMeal: Int = 0
    @State private var selectedMood: Mood = .normal
    @State private var imageData: Data? = nil
    @State private var time = Date()
    @State private var date = Date()
    @State private var isFixed: Bool = false
    @Query var meals: [Meal]
    @AppStorage("numberOfMeals") var numberOfMeals: Int = 1
    @Environment(\.modelContext) var modelContext
    
    let meal: Meal
    
    func addLog(){
        if let todayLog = meal.logs.last(where: { $0.ref!.name == meal.name && Calendar.current.isDate($0.date, inSameDayAs: Date()) }){
            todayLog.emotion = selectedMood
            todayLog.status = status
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
                modelContext.insert(meal)
            }
            let log = LogMeal(
                ref: meal,
                date: date,
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
                    Section("Nome da refeição"){
                        TextField("Digite o nome da refeição", text: $mealName)
                            .textFieldStyle(OutlinedTextFieldStyle())
                            .foregroundStyle(.secondary)
                    }
                    
                    Section("Horário"){
                        HStack{
                            
                            Text("Selecione o horário")
                                .foregroundStyle(.secondary)
                            Spacer()
                            DatePicker("Selecione a hora", selection: $time, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .tint(Color("VermelhoDailyBites"))
                        }
                        .padding(20)
                        .overlay{
                            RoundedRectangle( cornerRadius: 12)
                                .fill(.clear)
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                        
                    }
                  
                    
                    Section("Foto"){
                        PhotoPickerView(imageData: $imageData)
                    }
                    
                    Section("Emoção"){
                        HStack {
                            Spacer()
                            
                            ForEach(Mood.allCases, id: \.self) { mood in
                                
                                HStack {
                                    Text(mood.rawValue)
                                        .padding(10)
                                        .background(selectedMood == mood ? Color.red.opacity(0.3) : Color.clear)
                                        .onTapGesture {
                                            selectedMood = mood
                                        }

                                }
                                Spacer()
                                
                            }
                            .cornerRadius(32)
                        }
                        
                        
                        .padding(20)
                        .overlay{
                            RoundedRectangle( cornerRadius: 12)
                                .fill(.clear)
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                    }
                    .padding(.bottom, -10)
                    
                    Section("Pontualidade"){
                        Picker("Clique para escolher", selection: $status){
                            ForEach(Status.allCases, id: \.self) {
                                Text($0.title)
                            }
                            
                            
                        }
                        .padding(20)
                        .overlay{
                            RoundedRectangle( cornerRadius: 12)
                            
                                .fill(.clear)
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                    }
                    .foregroundStyle(.secondary)
                    .padding(.bottom, -10)
                    
                    Section("Duração da refeiçao"){
                        Stepper(value: $durationMeal, in: 0...60, step: 5){
                            Text("Tempo em minutos: \(durationMeal)")
                        }
                        .padding(20)
                        .overlay{
                            RoundedRectangle( cornerRadius: 12)
                            
                                .fill(.clear)
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                    }
                    .foregroundStyle(.secondary)
                    .padding(.bottom, -10)
                    
                    
                    Section("Descrição"){
                        TextField("Digite como foi sua refeição", text: $descriptionMeal, axis: .vertical)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .lineLimit(10, reservesSpace: true)
                            .textFieldStyle(OutlinedTextFieldStyleDescription())
                        
                    }
                    .padding(.bottom, -10)
                    
                    Toggle("Repetir", isOn: $isFixed)
                        .tint(Color("VermelhoDailyBites"))
                        .padding(20)
                        .overlay{
                            RoundedRectangle( cornerRadius: 12)
                                .fill(.clear)
                                .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                        }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle(Text("Refeição"))
               // .navigationSubtitle(Text(meal.time, style: .time))
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark")
                        {
                            addLog()
                            meal.name = mealName
                            meal.time = time
                        }
                        .tint(Color("VermelhoDailyBites"))
                    }
                }
                
            }
        .toolbar(.hidden, for: .tabBar)
        .scrollDismissesKeyboard(.immediately)
        .onAppear {
            mealName = meal.name
            time = meal.time
            isFixed = meal.isFixed
                       let thisMeal = meal.logs.last(where: { $0.ref!.name == meal.name && Calendar.current.isDate($0.date, inSameDayAs: Date())})
                       mealName = meal.name
       
                       if let imageData = thisMeal?.imageData {
                           self.imageData = imageData
                       }
                       descriptionMeal = thisMeal?.descriptionMeal ?? ""
                       status = thisMeal?.status ?? .pendente
                       selectedMood = thisMeal?.emotion ?? .normal
                       durationMeal = thisMeal?.durationMeal ?? 0
                       // isFixed = thisMeal?.ref!.isFixed ?? false
                   }
        }
    }



#Preview {
   // AddMealView()
}
