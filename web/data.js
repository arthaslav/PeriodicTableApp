// Данные химических элементов
const elements = [
    {
        id: 1,
        symbol: "H",
        name: "Водород",
        atomicMass: 1.008,
        category: "Неметалл",
        group: 1,
        period: 1,
        electronConfiguration: "1s¹",
        description: "Самый легкий и распространенный элемент во Вселенной"
    },
    {
        id: 2,
        symbol: "He",
        name: "Гелий",
        atomicMass: 4.003,
        category: "Благородный газ",
        group: 18,
        period: 1,
        electronConfiguration: "1s²",
        description: "Инертный газ, второй по распространенности во Вселенной"
    },
    {
        id: 3,
        symbol: "Li",
        name: "Литий",
        atomicMass: 6.941,
        category: "Щелочной металл",
        group: 1,
        period: 2,
        electronConfiguration: "[He] 2s¹",
        description: "Самый легкий металл, используется в батареях"
    },
    {
        id: 4,
        symbol: "Be",
        name: "Бериллий",
        atomicMass: 9.012,
        category: "Щелочноземельный металл",
        group: 2,
        period: 2,
        electronConfiguration: "[He] 2s²",
        description: "Легкий и прочный металл"
    },
    {
        id: 5,
        symbol: "B",
        name: "Бор",
        atomicMass: 10.81,
        category: "Металлоид",
        group: 13,
        period: 2,
        electronConfiguration: "[He] 2s² 2p¹",
        description: "Металлоид, используется в стекле и керамике"
    },
    {
        id: 6,
        symbol: "C",
        name: "Углерод",
        atomicMass: 12.01,
        category: "Неметалл",
        group: 14,
        period: 2,
        electronConfiguration: "[He] 2s² 2p²",
        description: "Основа органической жизни"
    },
    {
        id: 7,
        symbol: "N",
        name: "Азот",
        atomicMass: 14.01,
        category: "Неметалл",
        group: 15,
        period: 2,
        electronConfiguration: "[He] 2s² 2p³",
        description: "Составляет 78% атмосферы Земли"
    },
    {
        id: 8,
        symbol: "O",
        name: "Кислород",
        atomicMass: 16.00,
        category: "Неметалл",
        group: 16,
        period: 2,
        electronConfiguration: "[He] 2s² 2p⁴",
        description: "Необходим для дыхания, 21% атмосферы"
    },
    {
        id: 9,
        symbol: "F",
        name: "Фтор",
        atomicMass: 19.00,
        category: "Галоген",
        group: 17,
        period: 2,
        electronConfiguration: "[He] 2s² 2p⁵",
        description: "Самый реактивный элемент"
    },
    {
        id: 10,
        symbol: "Ne",
        name: "Неон",
        atomicMass: 20.18,
        category: "Благородный газ",
        group: 18,
        period: 2,
        electronConfiguration: "[He] 2s² 2p⁶",
        description: "Инертный газ, используется в неоновых лампах"
    },
    {
        id: 11,
        symbol: "Na",
        name: "Натрий",
        atomicMass: 22.99,
        category: "Щелочной металл",
        group: 1,
        period: 3,
        electronConfiguration: "[Ne] 3s¹",
        description: "Мягкий металл, компонент поваренной соли"
    },
    {
        id: 12,
        symbol: "Mg",
        name: "Магний",
        atomicMass: 24.31,
        category: "Щелочноземельный металл",
        group: 2,
        period: 3,
        electronConfiguration: "[Ne] 3s²",
        description: "Легкий металл, важен для фотосинтеза"
    },
    {
        id: 13,
        symbol: "Al",
        name: "Алюминий",
        atomicMass: 26.98,
        category: "Постпереходный металл",
        group: 13,
        period: 3,
        electronConfiguration: "[Ne] 3s² 3p¹",
        description: "Легкий и прочный металл"
    },
    {
        id: 14,
        symbol: "Si",
        name: "Кремний",
        atomicMass: 28.09,
        category: "Металлоид",
        group: 14,
        period: 3,
        electronConfiguration: "[Ne] 3s² 3p²",
        description: "Основа полупроводников и стекла"
    },
    {
        id: 15,
        symbol: "P",
        name: "Фосфор",
        atomicMass: 30.97,
        category: "Неметалл",
        group: 15,
        period: 3,
        electronConfiguration: "[Ne] 3s² 3p³",
        description: "Важен для ДНК и энергетического обмена"
    },
    {
        id: 16,
        symbol: "S",
        name: "Сера",
        atomicMass: 32.07,
        category: "Неметалл",
        group: 16,
        period: 3,
        electronConfiguration: "[Ne] 3s² 3p⁴",
        description: "Желтый неметалл, компонент белков"
    },
    {
        id: 17,
        symbol: "Cl",
        name: "Хлор",
        atomicMass: 35.45,
        category: "Галоген",
        group: 17,
        period: 3,
        electronConfiguration: "[Ne] 3s² 3p⁵",
        description: "Газ, используется для дезинфекции"
    },
    {
        id: 18,
        symbol: "Ar",
        name: "Аргон",
        atomicMass: 39.95,
        category: "Благородный газ",
        group: 18,
        period: 3,
        electronConfiguration: "[Ne] 3s² 3p⁶",
        description: "Инертный газ, 1% атмосферы"
    },
    {
        id: 19,
        symbol: "K",
        name: "Калий",
        atomicMass: 39.10,
        category: "Щелочной металл",
        group: 1,
        period: 4,
        electronConfiguration: "[Ar] 4s¹",
        description: "Важен для работы нервной системы"
    },
    {
        id: 20,
        symbol: "Ca",
        name: "Кальций",
        atomicMass: 40.08,
        category: "Щелочноземельный металл",
        group: 2,
        period: 4,
        electronConfiguration: "[Ar] 4s²",
        description: "Основной компонент костей и зубов"
    }
];

const categories = [
    "Все категории",
    "Щелочной металл",
    "Щелочноземельный металл",
    "Переходный металл",
    "Постпереходный металл",
    "Металлоид",
    "Неметалл",
    "Галоген",
    "Благородный газ",
    "Лантаноид",
    "Актиноид"
];
