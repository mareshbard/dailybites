//
//  HomeView.swift
//  DailyBites
//
//  Created by USER on 28/04/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("username") var username = ""
    @AppStorage("numberOfMeals") var numberOfMeals: Int = 1
    @Query var meals: [Meal]
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Olá, \(username)")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Date(), style: .date)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.body)
            }
            .padding(.vertical,20)
            Text("Refeições do dia")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            RefeicoesView(meals: meals)
                .navigationBarHidden(true)
        }
        .onAppear{
            var firstDay = meals[0].date.formatted(date: .abbreviated, time: .omitted)
            if (firstDay != Date().formatted(date: .abbreviated, time: .omitted)){
                newMeals()
                firstDay = Date().formatted(date: .abbreviated, time: .omitted)
            }
        }
        .padding(.horizontal, 24)
    }
    
    func newMeals(){
        for i in 0...numberOfMeals{
            var firstDay = meals[0].date.formatted(date: .abbreviated, time: .omitted)
            
            if (meals[i].date.formatted(date: .abbreviated, time: .omitted) == firstDay) {
                modelContext.insert(Meal(mealName: meals[i].mealName, date: Date(), time: meals[i].time, durationMeal: 0, status: .pendente, descriptionMeal: ""))
            }
        }
    }
}

#Preview {
    
    
    HomeView()
}
