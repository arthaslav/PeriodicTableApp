import Foundation

struct Element: Identifiable, Codable {
    let id: Int
    let symbol: String
    let name: String
    let atomicMass: Double
    let category: ElementCategory
    let group: Int?
    let period: Int
    let electronConfiguration: String
    let description: String
    
    enum ElementCategory: String, Codable, CaseIterable {
        case alkaliMetal = "Щелочной металл"
        case alkalineEarthMetal = "Щелочноземельный металл"
        case transitionMetal = "Переходный металл"
        case postTransitionMetal = "Постпереходный металл"
        case metalloid = "Металлоид"
        case nonmetal = "Неметалл"
        case halogen = "Галоген"
        case nobleGas = "Благородный газ"
        case lanthanide = "Лантаноид"
        case actinide = "Актиноид"
    }
}

class ElementsData: ObservableObject {
    @Published var elements: [Element] = []
    
    init() {
        loadElements()
    }
    
    func loadElements() {
        elements = [
            Element(id: 1, symbol: "H", name: "Водород", atomicMass: 1.008, category: .nonmetal, group: 1, period: 1, electronConfiguration: "1s¹", description: "Самый легкий и распространенный элемент во Вселенной"),
            Element(id: 2, symbol: "He", name: "Гелий", atomicMass: 4.003, category: .nobleGas, group: 18, period: 1, electronConfiguration: "1s²", description: "Инертный газ, второй по распространенности во Вселенной"),
            Element(id: 3, symbol: "Li", name: "Литий", atomicMass: 6.941, category: .alkaliMetal, group: 1, period: 2, electronConfiguration: "[He] 2s¹", description: "Самый легкий металл, используется в батареях"),
            Element(id: 4, symbol: "Be", name: "Бериллий", atomicMass: 9.012, category: .alkalineEarthMetal, group: 2, period: 2, electronConfiguration: "[He] 2s²", description: "Легкий и прочный металл"),
            Element(id: 5, symbol: "B", name: "Бор", atomicMass: 10.81, category: .metalloid, group: 13, period: 2, electronConfiguration: "[He] 2s² 2p¹", description: "Металлоид, используется в стекле и керамике"),
            Element(id: 6, symbol: "C", name: "Углерод", atomicMass: 12.01, category: .nonmetal, group: 14, period: 2, electronConfiguration: "[He] 2s² 2p²", description: "Основа органической жизни"),
            Element(id: 7, symbol: "N", name: "Азот", atomicMass: 14.01, category: .nonmetal, group: 15, period: 2, electronConfiguration: "[He] 2s² 2p³", description: "Составляет 78% атмосферы Земли"),
            Element(id: 8, symbol: "O", name: "Кислород", atomicMass: 16.00, category: .nonmetal, group: 16, period: 2, electronConfiguration: "[He] 2s² 2p⁴", description: "Необходим для дыхания, 21% атмосферы"),
            Element(id: 9, symbol: "F", name: "Фтор", atomicMass: 19.00, category: .halogen, group: 17, period: 2, electronConfiguration: "[He] 2s² 2p⁵", description: "Самый реактивный элемент"),
            Element(id: 10, symbol: "Ne", name: "Неон", atomicMass: 20.18, category: .nobleGas, group: 18, period: 2, electronConfiguration: "[He] 2s² 2p⁶", description: "Инертный газ, используется в неоновых лампах"),
            Element(id: 11, symbol: "Na", name: "Натрий", atomicMass: 22.99, category: .alkaliMetal, group: 1, period: 3, electronConfiguration: "[Ne] 3s¹", description: "Мягкий металл, компонент поваренной соли"),
            Element(id: 12, symbol: "Mg", name: "Магний", atomicMass: 24.31, category: .alkalineEarthMetal, group: 2, period: 3, electronConfiguration: "[Ne] 3s²", description: "Легкий металл, важен для фотосинтеза"),
            Element(id: 13, symbol: "Al", name: "Алюминий", atomicMass: 26.98, category: .postTransitionMetal, group: 13, period: 3, electronConfiguration: "[Ne] 3s² 3p¹", description: "Легкий и прочный металл"),
            Element(id: 14, symbol: "Si", name: "Кремний", atomicMass: 28.09, category: .metalloid, group: 14, period: 3, electronConfiguration: "[Ne] 3s² 3p²", description: "Основа полупроводников и стекла"),
            Element(id: 15, symbol: "P", name: "Фосфор", atomicMass: 30.97, category: .nonmetal, group: 15, period: 3, electronConfiguration: "[Ne] 3s² 3p³", description: "Важен для ДНК и энергетического обмена"),
            Element(id: 16, symbol: "S", name: "Сера", atomicMass: 32.07, category: .nonmetal, group: 16, period: 3, electronConfiguration: "[Ne] 3s² 3p⁴", description: "Желтый неметалл, компонент белков"),
            Element(id: 17, symbol: "Cl", name: "Хлор", atomicMass: 35.45, category: .halogen, group: 17, period: 3, electronConfiguration: "[Ne] 3s² 3p⁵", description: "Газ, используется для дезинфекции"),
            Element(id: 18, symbol: "Ar", name: "Аргон", atomicMass: 39.95, category: .nobleGas, group: 18, period: 3, electronConfiguration: "[Ne] 3s² 3p⁶", description: "Инертный газ, 1% атмосферы"),
            Element(id: 19, symbol: "K", name: "Калий", atomicMass: 39.10, category: .alkaliMetal, group: 1, period: 4, electronConfiguration: "[Ar] 4s¹", description: "Важен для работы нервной системы"),
            Element(id: 20, symbol: "Ca", name: "Кальций", atomicMass: 40.08, category: .alkalineEarthMetal, group: 2, period: 4, electronConfiguration: "[Ar] 4s²", description: "Основной компонент костей и зубов")
        ]
    }
}
