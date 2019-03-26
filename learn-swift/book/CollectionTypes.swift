/* * * Array * * */
/* * * * * * * * */

// массив в swift - это упорядоченный список элементов одного типа

// инициализируя массив таким образом, в дальнейшем невозможно будет
// изменить тип данных для его элементов
var someInts = [Int]()

// создание массива одинаковых элементов
let zeros = Array(repeating: 0, count: 5)

// создание массива объединяя уже существующие
// (с учетом соответствующих типов)
let units = Array(repeating: 1, count: 5)
let binary = zeros + units // [0, 0, 0, 0, 0, 1, 1, 1, 1, 1]

// добавление элементов
func arrayAddItems() {
    var randomInts = [1, 2, 3]
    randomInts.append(4)
    randomInts += [5, 6]
    // [1, 2, 3, 4, 5, 6]
}

// получение и установка значение по индексу с помощью subscript
func arraySubscript() {
    // var
    var values = ["a", "b", "c", "d", "f"]
    values[1] = "b+"
    
    // с помощью subscript можно так же изменять значения в диапазоне
    values[2...3] = ["c+", "d+"]
    // ["a", "b+", "c+", "d+", "f"]
}

// вставка и удаление
func arrayElementPositionHandle() {
    var values = ["a", "b", "c", "d"]
    values.insert("-a", at: 0)
    values.remove(at: 2)
    // ["-a", "a", "c", "d"]
    
    // выполняя операции с индексами, полезно убедиться что запрос
    // с конкретному индексу не будет вне диапазона -> не спровоцирует runtime error
    // (count & count - 1)
    
    // удаление последнего элемента
    values.removeLast()
}

// итерации
func arrayIterations() {
    let values = ["a", "b", "c", "d", "e"]
    
    for value in values {
        print(value)
    }
    
    for (index, value) in values.enumerated() {
        print(index, value) // 0, "a" ...
    }
}



/* * * Set * * */
/* * * * * * * */

// struct Set<Element> where Element : Hashable

// неупорядоченный список уникальных элементов одного типа
// чтобы коллекция Set могла содержать какой-либо элемент,
// он должен соответствовать протоколу Hashable

// ранее, создавая свой собственный тип, необходимо было вручную
// определять реализации для хеширования и сравнения, но в последних
// версиях языка (Swift 4.1) компилятор делат это сам и достаточно определить
// myNewFoo: Hashable {...}
// после чего такой тип ^ можно использовать в коллекции Set

// https://useyourloaf.com/blog/swift-hashable
// https://useyourloaf.com/blog/how-to-get-equatable-and-hashable-for-free/

struct Country: Hashable {
    let name: String
    let capital: String
    var visited: Bool
}

func setBasics() {
    let ukraine = Country(name: "Ukraine", capital: "Kyiv", visited: true)
    let germany = Country(name: "Germany", capital: "Berlin", visited: true)
    let spain = Country(name: "Spain", capital: "Madrid", visited: false)
    
    var visitedCountries = Set<Country>()
    
    // добавление элементов через insert
    visitedCountries.insert(ukraine)
    visitedCountries.insert(germany)
}

// инициализация Set с помощью литерала массива
func setInits() {
    var symbols: Set<String> = ["a", "b", "c", "d"]
    
    // короткая форма записи, без явного указания типа
    var values: Set = [1, 2, 3, 4]
}

// методы для удаления и проверки содержимого
func setMethods() {
    var letters: Set = ["a", "b", "c", "d"]
    
    letters.remove("a")
    
}




