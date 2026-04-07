import SwiftUI

struct SearchView: View {
    @ObservedObject var elementsData: ElementsData
    @State private var searchText = ""
    @State private var selectedCategory: Element.ElementCategory?
    @State private var selectedElement: Element?
    @State private var showFilterSheet = false
    
    var filteredElements: [Element] {
        var elements = elementsData.elements
        
        if !searchText.isEmpty {
            elements = elements.filter { element in
                element.name.localizedCaseInsensitiveContains(searchText) ||
                element.symbol.localizedCaseInsensitiveContains(searchText) ||
                "\(element.id)".contains(searchText)
            }
        }
        
        if let category = selectedCategory {
            elements = elements.filter { $0.category == category }
        }
        
        return elements.sorted { $0.id < $1.id }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Поиск по названию, символу или номеру", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
                
                // Filter Button
                HStack {
                    Button(action: { showFilterSheet = true }) {
                        HStack {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                            Text(selectedCategory?.rawValue ?? "Все категории")
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    
                    if selectedCategory != nil {
                        Button(action: { selectedCategory = nil }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    
                    Text("\(filteredElements.count) элементов")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                // Results List
                ScrollView {
                    LazyVStack(spacing: 1) {
                        ForEach(filteredElements) { element in
                            SearchResultRow(element: element)
                                .onTapGesture {
                                    selectedElement = element
                                }
                        }
                    }
                }
            }
            .navigationTitle("Поиск")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
            .sheet(item: $selectedElement) { element in
                ElementDetailView(element: element)
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheet(selectedCategory: $selectedCategory)
            }
        }
    }
}

struct SearchResultRow: View {
    let element: Element
    
    var body: some View {
        HStack(spacing: 16) {
            // Element Symbol Box
            VStack(spacing: 2) {
                Text(element.symbol)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("\(element.id)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }
            .frame(width: 60, height: 60)
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
            )
            
            // Element Info
            VStack(alignment: .leading, spacing: 4) {
                Text(element.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Text(element.category.rawValue)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Text("Атомная масса: \(String(format: "%.2f", element.atomicMass))")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.2)),
            alignment: .bottom
        )
    }
}

struct FilterSheet: View {
    @Binding var selectedCategory: Element.ElementCategory?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    selectedCategory = nil
                    dismiss()
                }) {
                    HStack {
                        Text("Все категории")
                            .foregroundColor(.black)
                        Spacer()
                        if selectedCategory == nil {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                        }
                    }
                }
                
                ForEach(Element.ElementCategory.allCases, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                        dismiss()
                    }) {
                        HStack {
                            Text(category.rawValue)
                                .foregroundColor(.black)
                            Spacer()
                            if selectedCategory == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Фильтр по категории")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}
