//
//  AddMealView.swift
//  DailyBites
//
//  Created by user on 24/04/26.
//

import SwiftUI
import SwiftData
import Foundation

struct AddMealView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var descriptionMeal: String = ""
    @State private var status: Status = Status.pendente
    
    var body: some View {
        NavigationStack {
            Form {
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

