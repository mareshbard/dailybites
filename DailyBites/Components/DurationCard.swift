import SwiftUI
import SwiftData
import Charts

struct DurationCard: View {

    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    @State var media: Int = 0
    @State var total: Int = 0
    var body: some View {
        let todayMeals = logs.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) && $0.status != .pendente && $0.status != .pulou}
       
        let total = todayMeals.reduce(0) { $0 + $1.durationMeal }
        let media = getAverage(total: total, count: todayMeals.count)
    
  
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "clock")
                    .accessibilityHidden(true)
                Text("TEMPO MÉDIO")
                    .font(.caption)
                    .bold()
                                }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .font(.caption)
                .foregroundColor(Color.verdeFonte)
  
           
                VStack(alignment: .center){
                    Text("\(media)")
                        .foregroundColor(Color.verdeFonte)
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 32))
                    Text("Minutos")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 18))
                        .foregroundStyle(Color.black)
                }
        }
        .accessibilityElement(children: .combine)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.verdeBackground)
        .cornerRadius(12)
        .onAppear {
        
        }
    }
    private func getAverage(total: Int, count: Int)->Int{
        if total == 0{
            return 0
        } else {
            return Int(total/count)
        }
    }
}

#Preview {
 
}
