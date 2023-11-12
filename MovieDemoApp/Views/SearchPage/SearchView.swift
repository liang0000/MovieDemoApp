import SwiftUI

struct SearchView: View {
    
    @State private var searchTxt: String = ""
    private var categories: [String] = ["Motivation", "Songs", "Tips", "Exercise"]
    @State private var pinsSelection: Pins = .all
    
    enum Pins: String, CaseIterable, Identifiable {
        case all, your
        
        var id: String { rawValue }
        
        var capitalized: String {
            return self.rawValue.prefix(1).capitalized + self.rawValue.dropFirst()
        }
    }
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .bold()
                    TextField("Search Pinterest", text: $searchTxt)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories, id: \.self) { categary in
                        Button {
                            
                        } label: {
                            
                            Text(categary)
                                .bold()
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                .padding(5)
            }
            .frame(maxWidth: .infinity)
            .background(.black)
            
            Picker("Pins", selection: $pinsSelection) {
                ForEach(Pins.allCases, id: \.self) { type in
                    Text("\(type.capitalized) Pins")
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            HomeView()
        }
        .background(.gray.opacity(0.3))
    }
}

#Preview {
    SearchView()
}
