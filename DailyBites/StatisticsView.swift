//
//  StatisticsView.swift
//  DailyBites
//
//  Created by user on 28/04/26.
//

import SwiftUI
import SwiftData
import Charts

struct StatusMeal: Identifiable {
    let id = UUID()
    var status: Status
    var count: Int
}

struct StatisticsView: View {
    
    @Query var meals: [Meal] = []
    @AppStorage("numberOfMeals") private var numberOfMeals: Int = 1
    
    @State private var countMealSunday: Int = 0

    var percentage: [Double]{
        
        var result: [Double] = []
        for mood in Mood.allCases {
            let filtered_meals: [Meal] = meals.filter({$0.status != .pendente && $0.status != .pulou})
            let filtered: [Meal] = filtered_meals.filter({$0.emotion == mood})
            let total: Double = Double(filtered_meals.count)
            let totalMood: Double = Double(filtered.count)
            if(total == 0){
                result.append(0)
            } else {
                result.append(totalMood/total * 100) // filtra e verifica todas as moods e faz o calculo de porcentagem
            }
        }
        return result
    }
    
    var status: [StatusMeal] {
        var result: [StatusMeal] = []
        for status in Status.allCases {
            let filtered: [Meal] = meals.filter({$0.status == status})
            let count = filtered.count
            result.append(StatusMeal(status: status, count: count))
            
        }
        return result
    }
    
    enum Semana: String, CaseIterable, Codable {
        
        case Dom = "Dom"
        case Seg = "Seg"
        case Ter = "Ter"
        case Qua = "Qua"
        case Qui = "Qui"
        case Sex = "Sex"
        case Sab = "Sáb"
        
        
        var weekday: Int {
            switch self {
            case .Dom:
                1
            case .Seg:
                2
            case .Ter:
                3
            case .Qua:
                4
            case .Qui:
                5
            case .Sex:
                6
            case .Sab:
                7
            }
        }
        
    }

    var body: some View{
        
        NavigationStack {
            
            VStack{
                
                Text("Estatísticas")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack{
                    
                    Spacer()
                    VStack{
                        Text("Pontualidade")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Chart {
                            ForEach(
                                status.filter({$0.status != .pendente})
                            ) { status in
                                SectorMark(
                                    angle: .value("Status", status.count),
                                    innerRadius: .ratio(0.05),
                                    outerRadius: .ratio(0.9),
                                    angularInset: 1
                                )
                                .foregroundStyle(by: .value("name", status.status.title))
                                .foregroundStyle(Color.red)
                            }
                        }
                        .chartLegend(position: .trailing, alignment: .center) {
                            VStack(alignment: .leading){
                                Spacer()
                                HStack {
                                    Color("VerdeDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                    Text("Realizada pontualmente")
                                        .foregroundStyle(Color.primary)
                                }
                                Spacer()
                                
                                HStack {
                                    Color("AmareloDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                    Text("Realizada com atraso")
                                        .foregroundStyle(Color.primary)
                                }
                                Spacer()
                                
                                HStack {
                                    Color("VermelhoDailyBites").frame(width: 20, height: 20).cornerRadius(5)
                                    Text("Não realizou")
                                        .foregroundStyle(Color.primary)
                                }
                                Spacer()
                            }
                            
                        }
                        .chartForegroundStyleScale([
                            Status.atrasado.title: Color("AmareloDailyBites"),
                            Status.pontual.title: Color("VerdeDailyBites"),
                            Status.pulou.title: Color("VermelhoDailyBites")
                        ])
                        .frame(alignment: .leading)
                        
                        //                    .padding(EdgeInsets(top: -90, leading: 0, bottom: 10, trailing: 0))
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                    
                    
                    VStack{
                        Text("Quantidade de refeições")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Chart{
                            ForEach(Semana.allCases, id: \.self){ dia in
                                BarMark(
                                    x: .value("Dias", dia.rawValue),
                                    y: .value("Refeicoes",
                                              getEatenMealsFromWeekday(dia)
//                                              Int.random(in: 0...numberOfMeals)
                                             )
                                )
                                .foregroundStyle(Color("CordeAção"))
                                
                                
                            }
                            
                        }
                        .chartYAxis{
                            AxisMarks(position: .leading, stroke: StrokeStyle(lineWidth: 0))
                        }
                        .chartXAxis{
                            AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                        }
                        //   .AxisGridLine(.hidden)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 180, alignment: .leading)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    Spacer()
                    
                    
                    VStack{
                        Text("MoodBar")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack{
                            
                            HStack {
                                
                                Spacer()
                                
                                ForEach(Mood.allCases, id: \.self){ mood in
                                    Text(mood.rawValue)//mostra os Moods
                                }
                                .padding(10)
                                .font(.largeTitle)
                                
                                Spacer()
                            }
                            
                            
                            .overlay{
                                RoundedRectangle( cornerRadius: 32)
                                
                                    .fill(.clear)
                                    .stroke(Color.red, style: StrokeStyle(lineWidth: 0.5))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            }
                            
                            HStack {
                                ForEach(percentage, id: \.self){ percentage in
                                    Text("\(String(format: "%.0f", percentage))%")
                                } //mostra as porcentagens
                                .padding(10)
                                .font(.body)
                                
                            }
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                        
                        
                        Spacer()
                    }
                    
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        
                }
                
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func getEatenMealsFromWeekday(_ day: Semana) -> Int {
        
        let count = meals.count { meal in
            let weekday = Calendar.current.component(.weekday, from: meal.date)
            return (meal.status == .pontual || meal.status == .atrasado) && weekday == day.weekday
        }
        
        return count
    }


}


#Preview {
    
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, configurations: configuration)
    
    let mockMeals: [Meal] = [
        Meal(
            mealName: "teste",
            date: .init(),
            time: .init(),
            imageData: nil,
            durationMeal: 10,
            status: .pulou,
            descriptionMeal: "Descrição",
            emotion: .normal
        ),
        
        Meal(
            mealName: "abc",
            date: .init(),
            time: .init(),
            imageData: nil,
            durationMeal: 10,
            status: .pontual,
            descriptionMeal: "def",
            emotion: .happy
        ),
        
        Meal(
            mealName: "xyz",
            date: .init(),
            time: .init(),
            imageData: nil,
            durationMeal: 10,
            status: .atrasado,
            descriptionMeal: "ijk",
            emotion: .sad
        ),
        
        Meal(
            mealName: "xyz",
            date: .init(),
            time: .init(),
            imageData: nil,
            durationMeal: 10,
            status: .pontual,
            descriptionMeal: "ijk",
            emotion: .sad
        ),
        Meal(
            mealName: "xyz",
            date: .init().addingTimeInterval(-24*60*60),
            time: .init(),
            imageData: nil,
            durationMeal: 10,
            status: .pontual,
            descriptionMeal: "ijk",
            emotion: .sad
        ),
        Meal(
            mealName: "xyz",
            date: .init().addingTimeInterval(-24*60*60),
            time: .init(),
            imageData: nil,
            durationMeal: 10,
            status: .pontual,
            descriptionMeal: "ijk",
            emotion: .sad
        )
    ]
    
    
    for meal in mockMeals {
        container.mainContext.insert(meal)
    }
    
    return StatisticsView()
        .modelContainer(container)
}



extension Calendar {
    private var currentDate: Date { return Date() }

    func isDateInThisWeek(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
      }
}
