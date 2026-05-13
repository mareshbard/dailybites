import SwiftUI
import SwiftData

struct StreakCard: View {
    
    @AppStorage("streak") var streak: Int = 1
    @AppStorage("lastStreakDate") var lastStreakDate: Double = 0
    @Query var meals: [Meal]
    
    var body: some View {
        
        HStack(spacing: 15) {
            Image("happy-apple")
            VStack(alignment: .leading) {
                Text("Continue assim!")
                    .bold()
                    .font(.title2)
                    .foregroundStyle(Color(.black))
                Text("\(streak) dia(s) registrando suas refeições")
                    .foregroundStyle(Color(.black))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(Color.lightRed)
        .cornerRadius(12)
        .onAppear { checkAction() }
        .onChange(of: meals) { checkAction() }
    }
    
    func checkAction() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let last = Date(timeIntervalSince1970: lastStreakDate)

        if calendar.isDate(last, inSameDayAs: today) {
            return
        }
       
        let completed = meals.contains {
            calendar.isDate($0.date, inSameDayAs: today) && $0.status != .pendente
        }
        guard completed else {
            return
        }
        
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        streak = calendar.isDate(last, inSameDayAs: yesterday) ? streak + 1 : 1
        lastStreakDate = today.timeIntervalSince1970
    }
}

#Preview {
    StreakCard()
}
