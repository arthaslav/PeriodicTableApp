import SwiftUI

struct QuizView: View {
    @ObservedObject var elementsData: ElementsData
    @StateObject private var quizManager = QuizManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if quizManager.isQuizActive {
                    ActiveQuizView(quizManager: quizManager)
                } else {
                    QuizStartView(quizManager: quizManager, elementsData: elementsData)
                }
            }
            .navigationTitle("Викторина")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
        }
    }
}

struct QuizStartView: View {
    @ObservedObject var quizManager: QuizManager
    @ObservedObject var elementsData: ElementsData
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: "brain.head.profile")
                .font(.system(size: 80))
                .foregroundColor(.black)
            
            Text("Проверьте свои знания")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            
            Text("Ответьте на вопросы о химических элементах")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                QuizModeButton(
                    title: "Угадай элемент по символу",
                    icon: "textformat.abc",
                    action: {
                        quizManager.startQuiz(mode: .guessElementBySymbol, elements: elementsData.elements)
                    }
                )
                
                QuizModeButton(
                    title: "Угадай символ по элементу",
                    icon: "character.textbox",
                    action: {
                        quizManager.startQuiz(mode: .guessSymbolByElement, elements: elementsData.elements)
                    }
                )
                
                QuizModeButton(
                    title: "Угадай атомный номер",
                    icon: "number.circle",
                    action: {
                        quizManager.startQuiz(mode: .guessAtomicNumber, elements: elementsData.elements)
                    }
                )
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct QuizModeButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 1)
            )
        }
    }
}

struct ActiveQuizView: View {
    @ObservedObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 0) {
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * quizManager.progress, height: 4)
                }
            }
            .frame(height: 4)
            
            // Score
            HStack {
                Text("Вопрос \(quizManager.currentQuestionIndex + 1) из \(quizManager.totalQuestions)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Счет: \(quizManager.score)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
            }
            .padding()
            
            if quizManager.showResult {
                QuizResultView(quizManager: quizManager)
            } else if let question = quizManager.currentQuestion {
                QuizQuestionView(question: question, quizManager: quizManager)
            }
        }
    }
}

struct QuizQuestionView: View {
    let question: QuizQuestion
    @ObservedObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Text(question.question)
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            VStack(spacing: 12) {
                ForEach(question.options, id: \.self) { option in
                    QuizOptionButton(
                        option: option,
                        isSelected: quizManager.selectedAnswer == option,
                        isCorrect: quizManager.hasAnswered && option == question.correctAnswer,
                        isWrong: quizManager.hasAnswered && quizManager.selectedAnswer == option && option != question.correctAnswer,
                        action: {
                            quizManager.selectAnswer(option)
                        }
                    )
                    .disabled(quizManager.hasAnswered)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            if quizManager.hasAnswered {
                Button(action: {
                    quizManager.nextQuestion()
                }) {
                    Text("Далее")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(12)
                }
                .padding()
            }
        }
    }
}

struct QuizOptionButton: View {
    let option: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(option)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor, lineWidth: 2)
                )
        }
    }
    
    var textColor: Color {
        if isCorrect { return .white }
        if isWrong { return .white }
        return .black
    }
    
    var backgroundColor: Color {
        if isCorrect { return .black }
        if isWrong { return .gray }
        if isSelected { return Color.gray.opacity(0.1) }
        return .white
    }
    
    var borderColor: Color {
        if isCorrect { return .black }
        if isWrong { return .gray }
        if isSelected { return .black }
        return Color.gray.opacity(0.3)
    }
}

struct QuizResultView: View {
    @ObservedObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: quizManager.score >= 7 ? "star.fill" : "checkmark.circle")
                .font(.system(size: 80))
                .foregroundColor(.black)
            
            Text("Викторина завершена!")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
            VStack(spacing: 8) {
                Text("Ваш результат")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                
                Text("\(quizManager.score) из \(quizManager.totalQuestions)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.black)
                
                Text(resultMessage)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                quizManager.resetQuiz()
            }) {
                Text("Начать заново")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding()
        }
    }
    
    var resultMessage: String {
        let percentage = Double(quizManager.score) / Double(quizManager.totalQuestions)
        if percentage >= 0.9 { return "Отлично! Вы эксперт в химии!" }
        if percentage >= 0.7 { return "Хорошо! Продолжайте учиться!" }
        if percentage >= 0.5 { return "Неплохо! Есть куда расти!" }
        return "Попробуйте еще раз!"
    }
}
