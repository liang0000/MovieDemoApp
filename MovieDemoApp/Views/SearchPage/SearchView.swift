import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .bold()
                    TextField("Search Pinterest", text: $viewModel.searchTxt)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Button {
                            
                        } label: {
                            Text(category)
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
            
            Picker("Pins", selection: $viewModel.pinsSelection) {
                ForEach(SearchViewModel.Pins.allCases, id: \.self) { type in
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
