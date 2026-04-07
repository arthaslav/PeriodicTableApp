# 🚀 Полная инструкция по деплою на GitHub

## Шаг 1: Установка Git (если еще не установлен)

1. Скачайте Git для Windows: https://git-scm.com/download/win
2. Установите с настройками по умолчанию
3. Откройте командную строку (cmd) и проверьте установку:
```bash
git --version
```

## Шаг 2: Создание репозитория на GitHub

1. Перейдите на https://github.com
2. Войдите в свой аккаунт (или создайте новый)
3. Нажмите зеленую кнопку "New" или "+" → "New repository"
4. Заполните:
   - Repository name: `PeriodicTableApp`
   - Description: `Интерактивная таблица Менделеева для iOS`
   - Выберите: Public (чтобы GitHub Actions работал бесплатно)
   - НЕ добавляйте README, .gitignore или license (у нас уже есть)
5. Нажмите "Create repository"

## Шаг 3: Инициализация Git и загрузка проекта

Откройте командную строку (cmd) и выполните команды:

```bash
# Перейдите в папку проекта
cd C:\PeriodicTableApp

# Инициализируйте Git репозиторий
git init

# Настройте Git (замените на свои данные)
git config user.name "Ваше Имя"
git config user.email "your.email@example.com"

# Добавьте все файлы
git add .

# Создайте первый коммит
git commit -m "Initial commit: Periodic Table iOS App"

# Подключите удаленный репозиторий (замените YOUR_USERNAME на ваш GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/PeriodicTableApp.git

# Переименуйте ветку в main (если нужно)
git branch -M main

# Загрузите код на GitHub
git push -u origin main
```

## Шаг 4: Проверка автоматической сборки

1. Перейдите на страницу вашего репозитория на GitHub
2. Нажмите на вкладку "Actions" вверху
3. Вы увидите запущенный workflow "iOS Build"
4. Нажмите на него, чтобы посмотреть процесс сборки
5. Подождите 5-10 минут, пока GitHub соберет приложение на macOS

### Что происходит при сборке:
- GitHub запускает виртуальную macOS машину
- Устанавливает Xcode
- Создает Xcode проект из ваших файлов
- Компилирует приложение для iOS симулятора
- Проверяет, что код компилируется без ошибок

## Шаг 5: Просмотр результатов

После успешной сборки вы увидите:
- ✅ Зеленую галочку в Actions
- Сообщение "iOS app built successfully!"

Если сборка упала:
- ❌ Красный крестик
- Нажмите на workflow, чтобы увидеть логи ошибок
- Исправьте ошибки в коде
- Сделайте новый commit и push

## Шаг 6: Обновление кода в будущем

Когда вы измените код:

```bash
cd C:\PeriodicTableApp

# Посмотрите измененные файлы
git status

# Добавьте изменения
git add .

# Создайте коммит с описанием изменений
git commit -m "Описание ваших изменений"

# Загрузите на GitHub
git push
```

После каждого push автоматически запустится сборка!

## Шаг 7: Скачивание проекта на Mac (когда будет доступ)

На Mac выполните:

```bash
# Клонируйте репозиторий
git clone https://github.com/YOUR_USERNAME/PeriodicTableApp.git

# Перейдите в папку
cd PeriodicTableApp

# Откройте проект в Xcode
open PeriodicTableApp.xcodeproj
```

Затем в Xcode:
1. Выберите симулятор (iPhone 15)
2. Нажмите Run (▶)
3. Приложение запустится!

## Полезные команды Git

```bash
# Посмотреть статус
git status

# Посмотреть историю коммитов
git log --oneline

# Отменить изменения в файле
git checkout -- filename.swift

# Создать новую ветку
git checkout -b feature-name

# Переключиться на другую ветку
git checkout main

# Слить ветку
git merge feature-name
```

## Troubleshooting

### Ошибка: "fatal: not a git repository"
```bash
cd C:\PeriodicTableApp
git init
```

### Ошибка: "remote origin already exists"
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/PeriodicTableApp.git
```

### Ошибка: "failed to push"
```bash
git pull origin main --rebase
git push origin main
```

### GitHub Actions не запускается
- Проверьте, что репозиторий Public
- Убедитесь, что файл `.github/workflows/ios-build.yml` загружен
- Перейдите в Settings → Actions → General → разрешите Actions

## Структура проекта на GitHub

```
PeriodicTableApp/
├── .github/
│   └── workflows/
│       └── ios-build.yml          # Автоматическая сборка
├── .gitignore                      # Игнорируемые файлы
├── README.md                       # Документация
├── Info.plist                      # Конфигурация iOS
├── PeriodicTableApp.swift          # Точка входа
├── ContentView.swift               # Главный экран
├── Element.swift                   # Модель данных
├── ElementDetailView.swift         # Детали элемента
├── SearchView.swift                # Поиск
├── QuizView.swift                  # Викторины
├── QuizManager.swift               # Логика викторин
└── Theme.swift                     # Дизайн система
```

## Следующие шаги

1. ✅ Загрузите проект на GitHub
2. ✅ Дождитесь успешной сборки
3. 📱 Когда будет Mac - откройте в Xcode
4. 🚀 Запустите на симуляторе или реальном устройстве
5. 📦 Опубликуйте в App Store (опционально)

Готово! Ваш проект теперь на GitHub с автоматической проверкой сборки! 🎉
