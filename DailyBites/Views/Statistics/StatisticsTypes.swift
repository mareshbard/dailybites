//
//  StatisticsTypes.swift
//  DailyBites
//
//  Created by Lucas Ibiapina on 15/06/26.
//


enum StatisticsTypes: String, CaseIterable, Identifiable {
    case pontualidade = "Pontualidade"
    case resistroSemanal = "Registro Semanal"
    case humor = "Humor"
    case tempoDasrefeicoes = "Tempo das refeições"
    case saciedade = "Saciedade"
    case totalDerefeicoes = "Total de refeições"
    
    var id: Self { self }
    
    var iconName: String {
        switch self {
        case .pontualidade:
            return "PontualityIcon"
        case .resistroSemanal:
            return "QuantityMealsIcon"
        case .humor:
            return "MoodIcon"
        case .tempoDasrefeicoes:
            return "MealsTimeIcon"
        case .saciedade:
            return "SacietyIcon"
        case .totalDerefeicoes:
            return "TotalMealsIcon"
        }
    }
    
    var question: String {
        switch self {
        case .pontualidade:
            return "O que a pontualidade diz sobre sua alimentação?"
        case .humor:
            return "O que o seu humor tem a ver com o que você come?"
        case .resistroSemanal:
            return "O que o registro semanal mostra?"
        case .tempoDasrefeicoes:
            return "O que o tempo das suas refeições revela?"
        case .saciedade:
            return "O que o nível de saciedade indica?"
        case .totalDerefeicoes:
            return "O que o total de refeições revela sobre sua rotina?"
        }
    }
    
    var description: String {
        switch self {
        case .pontualidade:
            return "Segundo o Ministério da Saúde, manter a pontualidade e a regularidade nas refeições equilibra os sinais de fome e saciedade. Essa rotina evita excessos e o consumo de ultraprocessados, sendo essencial para o bom funcionamento do metabolismo."
        case .humor:
            return "Em momentos de estresse ou tristeza, tendemos a buscar comidas reconfortantes, como doces e alimentos ricos em gorduras. Registrar como você se sente em cada refeição ajuda a identificar padrões emocionais antes que virem hábitos."
        case .resistroSemanal:
            return "Visualizar sua constância ao longo da semana é o primeiro passo para criar uma rotina alimentar sustentável. A regularidade é tão importante quanto a qualidade do que se come."
        case .tempoDasrefeicoes:
            return "Os hormônios da saciedade levam cerca de 20 a 30 minutos para agir. Mastigar bem prolonga a duração da refeição e melhora a percepção de saciedade, reduzindo a ingestão calórica total."
        case .saciedade:
            return "Acompanhar como você termina cada refeição revela se está comendo na quantidade certa.  Seu nível de saciedade  após cada refeição ajuda a identificar padrões e ajustar as refeições para sentir mais equilíbrio no dia a dia."
        case .totalDerefeicoes:
            return "Mais do que um número, o total acumulado mostra a consistência dos seus hábitos ao longo do tempo."
        }
    }
    
    var imageName: String {
        switch self {
        case .pontualidade:
            return "pineappleGlass"
        case .resistroSemanal:
            return "AppleQuantity"
        case .humor:
            return "AppleMood"
        case .tempoDasrefeicoes:
            return "GrapeTime"
        case .saciedade:
            return "GrapeSaciety"
        case .totalDerefeicoes:
            return "OrangeTotal"
        }
    }
}
