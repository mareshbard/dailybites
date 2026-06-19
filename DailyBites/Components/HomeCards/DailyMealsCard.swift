import SwiftUI
import SwiftData
import Charts

struct DailyMealsCard: View {
    var qtd: Int
    @AppStorage("numberOfMeals") private var numberOfMeals: Int = 1
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
 
    var body: some View {
        let todayMeals = logs.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
        let numOfExtras = todayMeals.count(where: {$0.ref?.isFixed == false && Calendar.current.isDate($0.date, inSameDayAs: Date())})

        let quantidades = [(nome: "Realizada", valor: todayMeals.count(where: {$0.status != .pulou && $0.status != .pendente})), (nome: "Não realizada", valor: numberOfMeals+numOfExtras - todayMeals.count(where: {$0.status != .pulou && $0.status != .pendente}))]
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "gauge.chart.leftthird.topthird.rightthird")
                    .accessibilityHidden(true)
                Text("REFEIÇÕES")
                    .bold()
                                }
            .font(.caption)
            .foregroundColor(Color.amareloGráfico)
            HStack{
               
                ZStack{
                    Chart(quantidades, id: \.nome) { qtd in
                        
                        SectorMark(angle: .value("Realizadas", qtd.valor),
                                   innerRadius: .ratio(0.65),
                                   angularInset: 3.0)
                        .cornerRadius(6)
                        .foregroundStyle(by: .value("Categoria", qtd.nome))
                    }
                    .chartForegroundStyleScale([
                        quantidades[0].nome: Color("amareloGráfico"),
                        quantidades[1].nome: Color(.white),
                    ])
                    .chartLegend(.hidden)
                    Text("\(quantidades[0].valor)/\(numberOfMeals+numOfExtras)")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 18))
                        .foregroundStyle(Color.black)
                    }
         
            }
          
            HStack {
            VStack(alignment: .leading){
  
                    if (numberOfMeals+numOfExtras - quantidades[0].valor) == 1 {
                        
                        Text("Falta")
                            .foregroundStyle(Color.black)
                        HStack(alignment: .top){
                            Text("\(numberOfMeals+numOfExtras - quantidades[0].valor)")
                                .foregroundColor(Color("amareloGráfico"))
                            Text("refeição")
                                .foregroundStyle(Color.black)
                        }
                    } else if (numberOfMeals+numOfExtras - quantidades[0].valor) == 0 {
                        Text("Refeições")
                            .foregroundStyle(Color.black)
                        Text("concluídas! ;)")
                            .foregroundStyle(Color.black)
                    }
                
                else {
                        Text("Faltam")
                        .foregroundStyle(Color.black)
                        HStack{
                            Text("\(numberOfMeals+numOfExtras - quantidades[0].valor)")
                                .foregroundColor(Color("amareloGráfico"))
                            Text("refeições")
                                .foregroundStyle(Color.black)
                        }
                    }
            
                }
            .accessibilityElement(children: .combine)
            .font(Font.custom("PlusJakartaSans-Semibold", size: 14))
              //  Spacer()
            }
        }
        .accessibilityElement(children: .contain)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.amareloBackground)
        .cornerRadius(12)
        
    }
}

#Preview {
   // DailyMealsCard(qtd: 3)
}
