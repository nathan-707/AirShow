
import SwiftUI
struct EntryCapsule: View {
    var topic: String
    var info: String
    var KM: Int = 0
    
    var body: some View {
        
        ZStack {
    
            VStack {
                Text(topic)
                    .foregroundColor(.green)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .padding(.bottom,5)
                    .multilineTextAlignment(.center) // Aligns text center and enables wrapping
                
                Text(info)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.horizontal)
                    .bold()
                    .multilineTextAlignment(.center) // Aligns text center and enables wrapping
                
//                if KM != 0 {
//                    Text("(" + String(KM) + " KPH)")
//                    .foregroundColor(.white)
//                    .font(.headline)
//                    .padding(.horizontal)
//                    .bold()
//                    .multilineTextAlignment(.center) // Aligns text center and enables wrapping
//                    
//                }
            }
        }
    }
}
