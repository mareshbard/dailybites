import SwiftUI

struct LogView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented: Bool = false
    var log: LogMeal
    
    
    var body: some View {
       NavigationStack {
           
           ScrollView {
               
               
               VStack( alignment: .leading) {
                   Section("PONTUALIDADE") {
                       Text("\(log.status.rawValue.capitalized)")
                           .modifier(TextInfo())
                           .padding(.bottom, 14)
                       
                   }
                   
                   
                   Section("TEMPO DA REFEIÇÃO") {
                       Text("\(log.durationMeal)")
                           .modifier(TextInfo())
                           .padding(.bottom, 16)
                   }
                   Section("SACIEDADE") {
                       Text("\(log.satiety.title)")
                           .modifier(TextInfo())
                           .padding(.bottom, 16)
                   }
                   Section("HUMOR ANTES DA REFEIÇÃO") {
                       HStack(spacing: 14) {
                           log.emotion.content
                               .resizable()
                               .frame(width: 33, height: 37)
                            
                           Text("\(log.emotion.title)")
                              
                       }
                       
                       .modifier(TextInfo())
                       .padding(.bottom, 16)
                       if let image = log.image {
                           Section("FOTO"){
                               Image(uiImage: image)
                                   .resizable()
                                   .frame(height: 300)
                                   .cornerRadius(15)
                                   .padding(.bottom, 16)
                           }
                          
                       }
                       if log.descriptionMeal.isEmpty {
                           
                       } else {
                           Section("DESCRIÇÃO") {
                               Text("\(log.descriptionMeal)")
                                   .modifier(TextInfo())
                                   .padding(.bottom, 16)
                           }
                       }
                   }
               }
           }
           .padding(.top, -30)
           .scrollIndicators(.hidden)
           .font(Font.subheadline.bold())
           .padding(.horizontal, 20)
           .onTapGesture {
               isPresented = true
           }
           .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button {
                       dismiss()
                   } label : {
                       Image(systemName: "xmark")
                   }
               }
               ToolbarItem(placement: .title) {
                   Text("\(log.ref!.name)")
                   
               }
           }
        }
        
       .background(Color(.secondarySystemBackground))
    }
    
}

#Preview {
    let meal1 = Meal(name: "Meal 1", logs: [], time: .now, isFixed: false)
    let meal2 = Meal(name: "Meal 2", logs: [], time: .now, isFixed: false)
    let log = LogMeal(
        ref: meal1,
        date: Date(),
        satiety: .cheio,
        imageData: nil,
        durationMeal: 10,
        status: .atrasado,
        descriptionMeal: "",
        emotion: .happy,
    )
    LogView(log: log)
}
