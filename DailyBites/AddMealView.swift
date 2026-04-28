//
//  AddMealView.swift
//  DailyBites
//
//  Created by user on 24/04/26.
//

import SwiftUI
import SwiftData
import Foundation

enum Mood: String, CaseIterable{
    case verysad = "😢"
    case sad = "😟"
    case normal = "😐"
    case happy = "🙂"
    case veryhappy = "😄"
    
}

struct AddMealView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var mealName: String = ""
    @State private var descriptionMeal: String = ""
    @State private var status: Status = Status.pendente
    @State private var durationMeal: Int = 0
    @State private var selectedMood: Mood = .normal
    @State private var imageData: Data? = nil
    @State private var time = Date()
    @State private var date = Date()
    
    @Environment(\.modelContext)
    private var modelContext
    
    func addMeal(){
        let newMeal = Meal(
            mealName: mealName,
            date: date, //Data que foi feita a refeicao
            time: time, //Horário que a pessoa cadastrou a refeicao
            imageData: imageData,
            durationMeal: durationMeal, //Tempo que a pessoa levou para comer
            status: status,
            descriptionMeal: descriptionMeal
        )
        modelContext.insert(newMeal)
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
                                
                             //   Spacer()
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
            .navigationTitle(Text("Adicionar Refeição"))
            .navigationSubtitle("Horas")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button {
                        dismiss()
                    } label: {
                        Image.init(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "checkmark")
                    {
                        
                    }.tint(Color("VermelhoDailyBites"))
                }
            }
            
        }
    }
    

}

#Preview {
    AddMealView()
}

