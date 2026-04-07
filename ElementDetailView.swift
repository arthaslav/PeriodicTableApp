import SwiftUI

struct ElementDetailView: View {
    let element: Element
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text(element.symbol)
                            .font(.system(size: 72, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text(element.name)
                            .font(.system(size: 28, weight: .medium))
                            .foregroundColor(.black)
                        
                        Text("Атомный номер: \(element.id)")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    
                    Divider()
                        .background(Color.black)
                    
                    // Properties
                    VStack(alignment: .leading, spacing: 16) {
                        PropertyRow(title: "Атомная масса", value: String(format: "%.3f", element.atomicMass))
                        PropertyRow(title: "Категория", value: element.category.rawValue)
                        if let group = element.group {
                            PropertyRow(title: "Группа", value: "\(group)")
                        }
                        PropertyRow(title: "Период", value: "\(element.period)")
                        PropertyRow(title: "Электронная конфигурация", value: element.electronConfiguration)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .background(Color.black)
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Описание")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(element.description)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct PropertyRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }
    }
}
