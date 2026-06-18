import SwiftUI

struct LogRecorded: View {
    @State var isPresented: Bool = false
    var log: LogMeal
    var body: some View {
        
        
        NavigationStack {
            if let image = log.image {
                
                HStack {
                    
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxWidth: 149, maxHeight: 130)
                        .clipped()
                    VStack(alignment: .leading) {
                        Text("\(log.ref!.name)")
                            .font(Font.custom("PlusJakartaSans-SemiBold", size: 20))
                            .foregroundColor(Color.primary)
                        Text(log.ref!.time, style: .time)
                            .foregroundColor(Color.primary)
                        Spacer()
                        Text(log.status.title)
//                            .foregroundColor(Color.primary)
                            .modifier(TagText(log: log))
                        
                    }
                    .foregroundColor(Color.font)
//                    .foregroundColor(Color.primary)
                    .padding(10)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
//                .background(Color.white)
                .cornerRadius(15)
            }
            else {
                VStack{
                    HStack{
                        
                        VStack(alignment: .leading){
                            Text(log.ref!.name)
                                .font(Font.custom("PlusJakartaSans-Semibold", size: 20))
                                .foregroundStyle(Color.primary)

                            Text(log.ref!.time, style: .time)
                                .font(Font.custom("PlusJakartaSans-Medium", size: 17))
                                .foregroundColor(Color.primary)
                        }
                        Spacer()
                        
                        Text(log.status.title)
                            .modifier(TagText(log: log))
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 15)
                }
                .frame(maxWidth: .infinity)
                .accessibilityHint("Clique para visualizar sua refeição")
                .frame(maxWidth: .infinity)
                .background(Color("mealBackground"))
                .cornerRadius(15)
            }
        }
        .background(Color("mealBackground"))
        .cornerRadius(15)
        .onTapGesture {
            isPresented = true
        }
        .sheet(isPresented: $isPresented){
            LogView(log: log)
        }
    }
    
}

#Preview {
    //  LogRecorded()
}
