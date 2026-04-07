import SwiftUI

struct ContentView: View {
    @StateObject private var elementsData = ElementsData()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PeriodicTableView(elementsData: elementsData)
                .tabItem {
                    Image(systemName: "square.grid.3x3")
                    Text("Таблица")
                }
                .tag(0)
            
            SearchView(elementsData: elementsData)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Поиск")
                }
                .tag(1)
            
            QuizView(elementsData: elementsData)
                .tabItem {
                    Image(systemName: "questionmark.circle")
                    Text("Викторина")
                }
                .tag(2)
        }
        .accentColor(.black)
    }
}

struct PeriodicTableView: View {
    @ObservedObject var elementsData: ElementsData
    @State private var selectedElement: Element?
    
    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical]) {
                VStack(spacing: 2) {
                    ForEach(1...7, id: \.self) { period in
                        HStack(spacing: 2) {
                            ForEach(elementsInPeriod(period)) { element in
                                ElementCell(element: element)
                                    .onTapGesture {
                                        selectedElement = element
                                    }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Таблица Менделеева")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
            .sheet(item: $selectedElement) { element in
                ElementDetailView(element: element)
            }
        }
    }
    
    func elementsInPeriod(_ period: Int) -> [Element] {
        elementsData.elements.filter { $0.period == period }
    }
}

struct ElementCell: View {
    let element: Element
    
    var body: some View {
        VStack(spacing: 2) {
            Text("\(element.id)")
                .font(.system(size: 8, weight: .light))
                .foregroundColor(.gray)
            
            Text(element.symbol)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
            
            Text(element.name)
                .font(.system(size: 7))
                .foregroundColor(.black)
                .lineLimit(1)
            
            Text(String(format: "%.2f", element.atomicMass))
                .font(.system(size: 7, weight: .light))
                .foregroundColor(.gray)
        }
        .frame(width: 60, height: 60)
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
