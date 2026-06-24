import SwiftUI
import SwiftData

struct StreakCard: View {
    
    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]
    
    private var streak: Int {
        calculateStreak(from: logs)
    }
    
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
                    .resizable()
                    .scaledToFit()
                
                    .frame(alignment: .trailing)
                    .padding(.leading, 35)
                    .accessibilityLabel("Mascote Uva de olho na sua sequencia")
                
            }
            Spacer()
            VStack(alignment: .leading) {
                
                
                Text("você registrou")
                    .font(Font.custom("PlusJakartaSans-Semibold", size: 16))
                    .foregroundStyle(Color.black)
                HStack(alignment: .bottom) {
                    Text("\(streak)")
                        .font(Font.custom("PlusJakartaSans-Semibold", size: 60))
                        .bold(true)
                        .foregroundStyle(Color.roxoAcao)
                    if streak == 1 {
                        Text("dia")
                            .font(Font.custom("PlusJakartaSans-Semibold", size: 16))
                            .foregroundStyle(Color.black)
                    } else {
                        Text("dias")
                            .font(Font.custom("PlusJakartaSans-Semibold", size: 16))
                            .foregroundStyle(Color.black)
                    }
                    
                     
                }
                .frame(maxWidth: .infinity)
            }
            .accessibilityElement(children: .combine)
        }
        .accessibilityElement(children: .combine)
        .padding(10)
        .background(Color.roxoBackground)
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
    }
    
    private func calculateStreak(from logs: [LogMeal], calendar: Calendar = .current) -> Int {
        let completedDays = Set(
            logs
                .filter { $0.status == .pontual || $0.status == .atrasado }
                .map { calendar.startOfDay(for: $0.date) }
        )
        
        let today = calendar.startOfDay(for: Date())
        var dayToCheck = today
        
        if !completedDays.contains(today) {
            guard let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
                  completedDays.contains(yesterday) else {
                return 0
            }
            dayToCheck = yesterday
        }
        
        var currentStreak = 0
        while completedDays.contains(dayToCheck) {
            currentStreak += 1
            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: dayToCheck) else {
                break
            }
            dayToCheck = previousDay
        }
        
        return currentStreak
    }
}

#Preview {
    StreakCard()
}
