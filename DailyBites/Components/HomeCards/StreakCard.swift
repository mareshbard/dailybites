import SwiftUI
import SwiftData
import WidgetKit

/// Fonte única do valor de streak. Além de calcular a sequência a partir dos
/// registros, mantém o widget da tela inicial em sincronia com os dados do app.
enum StreakStore {
    static let appGroup = "group.DailyBites"
    static let streakKey = "currentStreak"

    static func calculateStreak(from logs: [LogMeal], calendar: Calendar = .current) -> Int {
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

    /// Grava o streak atual no App Group compartilhado e pede ao WidgetKit para
    /// recarregar, de modo que o widget reflita o valor mais recente.
    static func sync(logs: [LogMeal]) {
        let streak = calculateStreak(from: logs)
        UserDefaults(suiteName: appGroup)?.set(streak, forKey: streakKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
}

/// View invisível que mantém o valor de streak do widget em sincronia com os
/// dados do app, independentemente de qual aba está visível no momento.
struct StreakWidgetSyncView: View {
    @Query(sort: \LogMeal.date, order: .forward) private var logs: [LogMeal]

    var body: some View {
        Color.clear
            .onAppear { StreakStore.sync(logs: logs) }
            .onChange(of: StreakStore.calculateStreak(from: logs)) { _, _ in
                StreakStore.sync(logs: logs)
            }
    }
}

struct StreakCard: View {

    @Query(sort: \LogMeal.date, order: .forward) var logs: [LogMeal]

    private var streak: Int {
        StreakStore.calculateStreak(from: logs)
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
}

#Preview {
    StreakCard()
}
