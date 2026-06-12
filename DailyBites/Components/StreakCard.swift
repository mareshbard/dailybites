import SwiftUI
import SwiftData

struct StreakCard: View {
    
    @AppStorage("streak") var streak: Int = 1
    @AppStorage("lastStreakDate") var lastStreakDate: Double = 0
    @Query var meals: [Meal]
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "bolt.fill")
                    .accessibilityHidden(true)
                Text("STREAK")
                    .bold()
                                }
            .font(.caption)

            .foregroundColor(Color.roxoAcao)
            HStack {
                Spacer()
                Image("Uva")
                    .accessibilityLabel("Mascote Uva de olho na sua sequencia")
            }
            Spacer()
            VStack(alignment: .leading) {
                
                
                Text("você registrou")
                    .font(Font.custom("PlusJakartaSans-Semibold", size: 16))
                HStack(alignment: .bottom) {
                    Text("\(streak)")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 60))
                        .bold(true)
                        .foregroundStyle(Color.roxoAcao)
                    
                    Text("dias")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 16))
                }
                .frame(maxWidth: .infinity)
            }
            .accessibilityElement(children: .combine)
        }
        .accessibilityElement(children: .contain)
        .padding(10)
        .background(Color.roxoBackground)
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
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
       
        let completed = logs.contains {
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
