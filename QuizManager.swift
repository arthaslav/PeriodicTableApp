import Foundation

class QuizManager: ObservableObject {
    @Published var isQuizActive = false
    @Published var currentQuestionIndex = 0
    @Published var score = 0
    @Published var questions: [QuizQuestion] = []
    @Published var selectedAnswer: String?
    @Published var hasAnswered = false
    @Published var showResult = false
    
    var currentQuestion: QuizQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var totalQuestions: Int {
        questions.count
    }
    
    var progress: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(currentQuestionIndex) / Double(totalQuestions)
    }
    
    enum QuizMode {
        case guessElementBySymbol
        case guessSymbolByElement
        case guessAtomicNumber
    }
    
    func startQuiz(mode: QuizMode, elements: [Element]) {
        isQuizActive = true
        currentQuestionIndex = 0
        score = 0
        showResult = false
        questions = generateQuestions(mode: mode, elements: elements, count: 10)
    }
    
    func generateQuestions(mode: QuizMode, elements: [Element], count: Int) -> [QuizQuestion] {
        var generatedQuestions: [QuizQuestion] = []
        let shuffledElements = elements.shuffled()
        
        for i in 0..<min(count, shuffledElements.count) {
            let element = shuffledElements[i]
            let question: QuizQuestion
            
            switch mode {
            case .guessElementBySymbol:
                question = createGuessElementBySymbolQuestion(element: element, allElements: elements)
            case .guessSymbolByElement:
                question = createGuessSymbolByElementQuestion(element: element, allElements: elements)
            case .guessAtomicNumber:
                question = createGuessAtomicNumberQuestion(element: element, allElements: elements)
            }
            
            generatedQuestions.append(question)
        }
        
        return generatedQuestions
    }
    
    func createGuessElementBySymbolQuestion(element: Element, allElements: [Element]) -> QuizQuestion {
        var options = [element.name]
        let otherElements = allElements.filter { $0.id != element.id }.shuffled()
        
        for i in 0..<3 {
            if i < otherElements.count {
                options.append(otherElements[i].name)
            }
        }
        
        return QuizQuestion(
            question: "Какой элемент имеет символ \(element.symbol)?",
            options: options.shuffled(),
            correctAnswer: element.name
        )
    }
    
    func createGuessSymbolByElementQuestion(element: Element, allElements: [Element]) -> QuizQuestion {
        var options = [element.symbol]
        let otherElements = allElements.filter { $0.id != element.id }.shuffled()
        
        for i in 0..<3 {
            if i < otherElements.count {
                options.append(otherElements[i].symbol)
            }
        }
        
        return QuizQuestion(
            question: "Какой символ у элемента \(element.name)?",
            options: options.shuffled(),
            correctAnswer: element.symbol
        )
    }
    
    func createGuessAtomicNumberQuestion(element: Element, allElements: [Element]) -> QuizQuestion {
        var options = ["\(element.id)"]
        let otherElements = allElements.filter { $0.id != element.id }.shuffled()
        
        for i in 0..<3 {
            if i < otherElements.count {
                options.append("\(otherElements[i].id)")
            }
        }
        
        return QuizQuestion(
            question: "Какой атомный номер у элемента \(element.name)?",
            options: options.shuffled(),
            correctAnswer: "\(element.id)"
        )
    }
    
    func selectAnswer(_ answer: String) {
        guard !hasAnswered else { return }
        
        selectedAnswer = answer
        hasAnswered = true
        
        if answer == currentQuestion?.correctAnswer {
            score += 1
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        selectedAnswer = nil
        hasAnswered = false
        
        if currentQuestionIndex >= questions.count {
            showResult = true
        }
    }
    
    func resetQuiz() {
        isQuizActive = false
        currentQuestionIndex = 0
        score = 0
        questions = []
        selectedAnswer = nil
        hasAnswered = false
        showResult = false
    }
}

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: String
}
