import SwiftUI
import Foundation

struct EmojiSelector: View {
    
    @Binding var selectedMood: Mood
    @State private var mood: Mood = .neutral
    let feedback = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        HStack(spacing:2){
            ForEach(Mood.allCases, id: \.self) { mood in
                VStack {
                    mood.content
                        .resizable()
                        .scaledToFit()
                        .frame(width:50, height:50, alignment: .top)
                    
                    Text(mood.title)
                    
                        .font(Font.subheadline)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .accessibilityValue(Text("\(mood.description)"))
                .frame(maxWidth: .infinity, minHeight: 100, alignment: .top)
                .onTapGesture {
                    selectedMood = mood
                    feedback.prepare()
                    feedback.impactOccurred()
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selectedMood == mood ? Color("LilasDailyBites") : Color.clear)
                        .frame(minWidth:50, minHeight:110, alignment:.leading)
                )
            }
            
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
        )
    }
}
