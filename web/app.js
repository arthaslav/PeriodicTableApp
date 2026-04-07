// App State
let currentView = 'table';
let selectedCategory = 'Все категории';
let quizMode = null;
let quizQuestions = [];
let currentQuestionIndex = 0;
let quizScore = 0;
let hasAnswered = false;

// Initialize App
document.addEventListener('DOMContentLoaded', () => {
    initNavigation();
    renderPeriodicTable();
    initSearch();
    initQuiz();
});

// Navigation
function initNavigation() {
    const navBtns = document.querySelectorAll('.nav-btn');
    navBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const view = btn.dataset.view;
            switchView(view);
        });
    });
}

function switchView(view) {
    currentView = view;
    
    // Update nav buttons
    document.querySelectorAll('.nav-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.view === view);
    });
    
    // Update views
    document.querySelectorAll('.view').forEach(v => {
        v.classList.toggle('active', v.id === `${view}-view`);
    });
}

// Periodic Table
function renderPeriodicTable() {
    const table = document.getElementById('periodic-table');
    table.innerHTML = '';
    
    // Create 7 periods x 18 groups grid
    for (let period = 1; period <= 7; period++) {
        for (let group = 1; group <= 18; group++) {
            const element = elements.find(e => e.period === period && e.group === group);
            
            if (element) {
                const cell = createElementCell(element);
                table.appendChild(cell);
            } else {
                const emptyCell = document.createElement('div');
                emptyCell.className = 'empty-cell';
                table.appendChild(emptyCell);
            }
        }
    }
}

function createElementCell(element) {
    const cell = document.createElement('div');
    cell.className = 'element-cell';
    cell.innerHTML = `
        <span class="element-number">${element.id}</span>
        <span class="element-symbol">${element.symbol}</span>
        <span class="element-name">${element.name}</span>
        <span class="element-mass">${element.atomicMass.toFixed(2)}</span>
    `;
    cell.addEventListener('click', () => showElementDetail(element));
    return cell;
}

function showElementDetail(element) {
    const modal = document.getElementById('element-modal');
    const detail = document.getElementById('element-detail');
    
    detail.innerHTML = `
        <div class="detail-header">
            <div class="detail-symbol">${element.symbol}</div>
            <div class="detail-name">${element.name}</div>
            <div class="detail-number">Атомный номер: ${element.id}</div>
        </div>
        
        <div class="detail-divider"></div>
        
        <div class="detail-properties">
            <div class="detail-property">
                <span class="property-label">Атомная масса</span>
                <span class="property-value">${element.atomicMass.toFixed(3)}</span>
            </div>
            <div class="detail-property">
                <span class="property-label">Категория</span>
                <span class="property-value">${element.category}</span>
            </div>
            ${element.group ? `
            <div class="detail-property">
                <span class="property-label">Группа</span>
                <span class="property-value">${element.group}</span>
            </div>
            ` : ''}
            <div class="detail-property">
                <span class="property-label">Период</span>
                <span class="property-value">${element.period}</span>
            </div>
            <div class="detail-property">
                <span class="property-label">Электронная конфигурация</span>
                <span class="property-value">${element.electronConfiguration}</span>
            </div>
        </div>
        
        <div class="detail-divider"></div>
        
        <div>
            <div class="detail-description-title">Описание</div>
            <div class="detail-description-text">${element.description}</div>
        </div>
    `;
    
    modal.classList.add('active');
}

// Search
function initSearch() {
    const searchInput = document.getElementById('search-input');
    const filterBtn = document.getElementById('filter-btn');
    
    searchInput.addEventListener('input', (e) => {
        performSearch(e.target.value);
    });
    
    filterBtn.addEventListener('click', showFilterModal);
    
    // Initial render
    performSearch('');
}

function performSearch(query) {
    let filtered = elements;
    
    // Filter by search query
    if (query) {
        filtered = filtered.filter(e => 
            e.name.toLowerCase().includes(query.toLowerCase()) ||
            e.symbol.toLowerCase().includes(query.toLowerCase()) ||
            e.id.toString().includes(query)
        );
    }
    
    // Filter by category
    if (selectedCategory !== 'Все категории') {
        filtered = filtered.filter(e => e.category === selectedCategory);
    }
    
    renderSearchResults(filtered);
}

function renderSearchResults(results) {
    const container = document.getElementById('search-results');
    
    if (results.length === 0) {
        container.innerHTML = '<div style="padding: 40px; text-align: center; color: var(--gray);">Ничего не найдено</div>';
        return;
    }
    
    container.innerHTML = results.map(element => `
        <div class="search-result-item" onclick="showElementDetail(elements[${elements.indexOf(element)}])">
            <div class="result-symbol-box">
                <div class="result-symbol">${element.symbol}</div>
                <div class="result-number">${element.id}</div>
            </div>
            <div class="result-info">
                <div class="result-name">${element.name}</div>
                <div class="result-category">${element.category}</div>
                <div class="result-mass">Атомная масса: ${element.atomicMass.toFixed(2)}</div>
            </div>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <polyline points="9 18 15 12 9 6"></polyline>
            </svg>
        </div>
    `).join('');
}

function showFilterModal() {
    const modal = document.getElementById('filter-modal');
    const options = document.getElementById('filter-options');
    
    options.innerHTML = categories.map(cat => `
        <div class="filter-option ${cat === selectedCategory ? 'selected' : ''}" onclick="selectCategory('${cat}')">
            <span>${cat}</span>
            ${cat === selectedCategory ? '<span>✓</span>' : ''}
        </div>
    `).join('');
    
    modal.classList.add('active');
}

function selectCategory(category) {
    selectedCategory = category;
    document.getElementById('filter-text').textContent = category;
    closeModal('filter-modal');
    performSearch(document.getElementById('search-input').value);
}

// Quiz
function initQuiz() {
    renderQuizStart();
}

function renderQuizStart() {
    const container = document.getElementById('quiz-container');
    container.innerHTML = `
        <div class="quiz-start">
            <div class="quiz-icon">🧠</div>
            <div class="quiz-title">Проверьте свои знания</div>
            <div class="quiz-subtitle">Ответьте на вопросы о химических элементах</div>
            
            <div class="quiz-modes">
                <button class="quiz-mode-btn" onclick="startQuiz('symbol')">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M4 7V4h16v3M9 20h6M12 4v16"></path>
                    </svg>
                    <span>Угадай элемент по символу</span>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 18 15 12 9 6"></polyline>
                    </svg>
                </button>
                
                <button class="quiz-mode-btn" onclick="startQuiz('element')">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <line x1="9" y1="9" x2="15" y2="15"></line>
                        <line x1="15" y1="9" x2="9" y2="15"></line>
                    </svg>
                    <span>Угадай символ по элементу</span>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 18 15 12 9 6"></polyline>
                    </svg>
                </button>
                
                <button class="quiz-mode-btn" onclick="startQuiz('number')">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"></circle>
                        <line x1="12" y1="8" x2="12" y2="12"></line>
                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                    </svg>
                    <span>Угадай атомный номер</span>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="9 18 15 12 9 6"></polyline>
                    </svg>
                </button>
            </div>
        </div>
    `;
}

function startQuiz(mode) {
    quizMode = mode;
    currentQuestionIndex = 0;
    quizScore = 0;
    hasAnswered = false;
    
    // Generate questions
    quizQuestions = generateQuestions(mode, 10);
    
    renderQuizQuestion();
}

function generateQuestions(mode, count) {
    const shuffled = [...elements].sort(() => Math.random() - 0.5);
    const questions = [];
    
    for (let i = 0; i < Math.min(count, shuffled.length); i++) {
        const element = shuffled[i];
        const otherElements = elements.filter(e => e.id !== element.id).sort(() => Math.random() - 0.5);
        
        let question, correctAnswer, options;
        
        if (mode === 'symbol') {
            question = `Какой элемент имеет символ ${element.symbol}?`;
            correctAnswer = element.name;
            options = [element.name, otherElements[0].name, otherElements[1].name, otherElements[2].name];
        } else if (mode === 'element') {
            question = `Какой символ у элемента ${element.name}?`;
            correctAnswer = element.symbol;
            options = [element.symbol, otherElements[0].symbol, otherElements[1].symbol, otherElements[2].symbol];
        } else {
            question = `Какой атомный номер у элемента ${element.name}?`;
            correctAnswer = element.id.toString();
            options = [element.id.toString(), otherElements[0].id.toString(), otherElements[1].id.toString(), otherElements[2].id.toString()];
        }
        
        questions.push({
            question,
            correctAnswer,
            options: options.sort(() => Math.random() - 0.5)
        });
    }
    
    return questions;
}

function renderQuizQuestion() {
    const container = document.getElementById('quiz-container');
    const question = quizQuestions[currentQuestionIndex];
    const progress = ((currentQuestionIndex) / quizQuestions.length) * 100;
    
    container.innerHTML = `
        <div class="quiz-active">
            <div class="quiz-progress">
                <div class="quiz-progress-bar" style="width: ${progress}%"></div>
            </div>
            
            <div class="quiz-header">
                <span>Вопрос ${currentQuestionIndex + 1} из ${quizQuestions.length}</span>
                <span>Счет: ${quizScore}</span>
            </div>
            
            <div class="quiz-question">${question.question}</div>
            
            <div class="quiz-options">
                ${question.options.map(option => `
                    <button class="quiz-option" onclick="selectAnswer('${option}')">${option}</button>
                `).join('')}
            </div>
            
            <button class="quiz-next-btn" style="display: none;" onclick="nextQuestion()">Далее</button>
        </div>
    `;
}

function selectAnswer(answer) {
    if (hasAnswered) return;
    
    hasAnswered = true;
    const question = quizQuestions[currentQuestionIndex];
    const isCorrect = answer === question.correctAnswer;
    
    if (isCorrect) {
        quizScore++;
    }
    
    // Update UI
    const options = document.querySelectorAll('.quiz-option');
    options.forEach(opt => {
        opt.disabled = true;
        if (opt.textContent === question.correctAnswer) {
            opt.classList.add('correct');
        } else if (opt.textContent === answer && !isCorrect) {
            opt.classList.add('wrong');
        }
    });
    
    document.querySelector('.quiz-next-btn').style.display = 'block';
}

function nextQuestion() {
    hasAnswered = false;
    currentQuestionIndex++;
    
    if (currentQuestionIndex >= quizQuestions.length) {
        renderQuizResult();
    } else {
        renderQuizQuestion();
    }
}

function renderQuizResult() {
    const container = document.getElementById('quiz-container');
    const percentage = (quizScore / quizQuestions.length);
    
    let message, icon;
    if (percentage >= 0.9) {
        message = "Отлично! Вы эксперт в химии!";
        icon = "⭐";
    } else if (percentage >= 0.7) {
        message = "Хорошо! Продолжайте учиться!";
        icon = "✓";
    } else if (percentage >= 0.5) {
        message = "Неплохо! Есть куда расти!";
        icon = "👍";
    } else {
        message = "Попробуйте еще раз!";
        icon = "📚";
    }
    
    container.innerHTML = `
        <div class="quiz-result">
            <div class="quiz-result-icon">${icon}</div>
            <div class="quiz-result-title">Викторина завершена!</div>
            
            <div class="quiz-result-score">
                <div class="quiz-result-label">Ваш результат</div>
                <div class="quiz-result-number">${quizScore} из ${quizQuestions.length}</div>
            </div>
            
            <div class="quiz-result-message">${message}</div>
            
            <button class="quiz-restart-btn" onclick="renderQuizStart()">Начать заново</button>
        </div>
    `;
}

// Modal
document.querySelectorAll('.modal-close').forEach(btn => {
    btn.addEventListener('click', () => {
        btn.closest('.modal').classList.remove('active');
    });
});

document.querySelectorAll('.modal').forEach(modal => {
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.classList.remove('active');
        }
    });
});

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('active');
}
