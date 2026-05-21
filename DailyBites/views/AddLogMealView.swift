import SwiftUI
import SwiftData
import Foundation

struct AddLogMealView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) var dismiss
    
    @State private var mealName: String = ""
    @State private var descriptionMeal: String = ""
    @State private var status: Status = Status.pendente
    @State private var durationMeal: Int = 0
    @State private var selectedMood: Mood = .normal
    @State private var imageData: Data? = nil
    @State private var time = Date()
    @State private var date = Date()
    let meal: Meal
    
    func addLog(){
        if let todayLog = meal.logs.last(where: { $0.ref!.name == meal.name }){
            todayLog.emotion = selectedMood
            todayLog.status = status
            todayLog.descriptionMeal = descriptionMeal
            todayLog.durationMeal = durationMeal
            todayLog.imageData = imageData
        }
        else{
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
        
        try? modelContext.save()
        
        dismiss()
    }

    var body: some View {
        NavigationStack {
                Form {
                    
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
//                                        .onAppear{
//                                            
//                                            selectedMood = log.emotion
//                                        }
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
                    
                    Section("Horário"){
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
                    
                }
                .scrollContentBackground(.hidden)
                .navigationTitle(Text("Refeição"))
                .navigationSubtitle(Text(meal.time, style: .time))
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar", systemImage: "checkmark")
                        {
                            addLog()
                        }
//                        .disabled(imageData == nil && log.status != .pendente)
                        .tint(Color("VermelhoDailyBites"))
                        
                    }
                }
                
            }
        .toolbar(.hidden, for: .tabBar)
        .scrollDismissesKeyboard(.immediately)
        .onAppear {
                       let thisMeal = meal.logs.last(where: { $0.ref!.name == meal.name })
                       mealName = meal.name
       
                       if let imageData = thisMeal?.imageData {
                           self.imageData = imageData
                       }
                       descriptionMeal = thisMeal?.descriptionMeal ?? ""
                       status = thisMeal?.status ?? .pendente
                       selectedMood = thisMeal?.emotion ?? .happy
                       durationMeal = thisMeal?.durationMeal ?? 0
                   }
        }
    }



#Preview {
   // AddMealView()
}

