// https://docs.swift.org/swift-book/LanguageGuide/Initialization.html

// основная задача инициализаторов убедиться в том, что новые экземпляры 
// создаются корректно перед тем как они будут впервые использованы (с точки зрения их props)


// *  *  *  Значения по умолчанию  *  *  *
// *  *  *  *  *  *  *  *  *  *  *  *  *  *

// если свойство всегда получает одно и то же значение, следует передавать его 
// как значение по умолчанию при объявлении свойства, нежели через инициализатор

// конечный результат один и тот же, однако при объявлении значения по-умолчанию, 
// передаваемое значение связывается со свойством более тесно (с точки зрения реализации языка)

struct Car {
    // если возникнет необходимость перееопределить значение в init, свойство
    // должно быть изменяемым -> var
    var wheelsAmount: Int = 4
    var model: Model
    
    init(model: Model) {
        self.model = model
    }
}



// *  *  *  Различные инициализаторы  *  *  *
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

struct CelsiusTemperature {
    var temperature: Double
    
    init(fromFahrenheit: Double) {
        temperature = (fromFahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin: Double) {
        temperature = fromKelvin - 273.15
    }
    
    // аргументы в init, так же как и в функциях, могут иметь внешнее и внутренее имя
    init(_ celsius: Double) {
        temperature = celsius
    }
    
    init()
}

// основнной способ, с помощью которого swift определяет какой init  
// использовать - это аргументы и их имена
let fahrenheitTemperature = CelsiusTemperature(fromFahrenheit: 212.0)
let kelvinTemperature = CelsiusTemperature(fromKelvin: 273.15)
let baseTemperature = CelsiusTemperature(36.6)


struct Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let someCoolored = Color(red: 1.0, green: 0.0, blue: 1.0)
let whiteColored = Color(white: 0.5)



// *  *  *  Опциональные значения  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *

// в ситуациях, когда свойство может быть в состоянии "без значения",
// во время инициализации или вообще, иеется возможность сделать его опциональным

// такие свойства автоматически получат nil значение, указывающее на то, что
// свойства намеренным образом не должны получать значения во время инициализации

class Survey {
    let question: String
    var response: String?
    
    init(question: String) {
        self.question = question
    }
}

let surv = Survey(question: "2 + 2?")

// здесь логичная закономерность: ответ на вопрос не будет известен, пока вопрос не будет задан
surv.response = "Probably it's 4"



// *  *  *  Default initializers  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

// если все свойства получат значения по умолчанию, инициализатор будет создан автоматически
class Main {
    let first = True
    let second = False
    let optional: Boolean?
}

let main = Main()



// *  *  *  Struct Memberwise Initializers  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

// в том случае, если внутри структуры не было объявлено каких-либо инициализаторов, 
// такая структура получит memberwise initializer
// в отличие от инициализаторов по умолчанию ^, структура получит memberwise initializer 
// даже в том случае, если свойства не получили значения по умолчанию 

// memberwise initializer - это упрощенный способ создания экземпляров структур, 
// у которых нет кастомных инициализаторов

struct Size {
    let width: Int
    let height: Int
    var mass: Int = 200
}

// значения в свойства записываются через имена соответственно, порядок имеет значение
let couple = Size(width: 2, height: 2)

// в том случае, если у свойства уже есть значения по умолчанию, его можно пропустить при
// инициализации структуры



// *  *  *  Initializer Delegation (value type > struct/enum)  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

// одни инициализаторы могут вызывать другие, чтобы выполнить часть 
// инициализации экземпляра 
// этот процесс называется делегированием инициализаторов и служит
// для избежания дублирования когда среди инициализаторов

// правила работы такого делегирования отличаются для типов данных value и class:
// structures и enums относительно просты в этом плане - так как они не поддерживают
// наследование и делегирование будет относиться только к их собственным инициалиизаторам, 
// в то время как классы, наследуясь, несут дополнительную ответственность за наследуемые свойства  

enum CarEngineType {
    case petrol, disel, hybrid, electro, superEngine
}

struct Car {
    var engineType: CarEngineType = .petrol
}

struct SuperCar {
    var car = Car()

    init() {}

    init(engineType: CarEngineType) {
        car.engineType = engineType
    }

    init(superEngineFirstType: CarEngineType, superEngineSecondType: CarEngineType) {
        // ... do some stuff with engine types ...
        
        // обращение к одному из init через self.init (делегирование)
        // такое обращение к init возможно только из другого init
        self.init(engineType: .superEngine)
    }
}

var defaultCar = SuperCar()
var hybridCar = SuperCar(engineType: .hybrid)
var superCar = SuperCar(superEngineFirstType: .disel, superEngineSecondType: .electro)

print(defaultCar.car) // Car(engineType: CarEngineType.petrol)
print(hybridCar.car) // Car(engineType: CarEngineType.hybrid)
print(superCar.car) // Car(engineType: CarEngineType.superEngine)



// *  *  *  Failable initializers for structs  *  *  *
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 

// существует два сопоба обработать ошибки во время инициализации: использовать
// failable inits или записывать обработчики throws прямо в инициализаторах

// failable inits возвращают optional значение, а так же могут возвращать nil
// но лучше всего они подходят как раз для nil cases

struct FuelTank {
    var currentAmount: Int
    var currentLiquidType: String?

    init?(currentAmount: Int, currentLiquidType: String?) {
        if currentAmount < 0 {
            return nil
        }

        self.currentAmount = currentAmount
        self.currentLiquidType = currentLiquidType
    }   
}

if let fuelTank = FuelTank(currentAmount: -100, currentLiquidType: "Nitro") {
    print("Current amount > 0")
}


// *  *  *  Throwing  *  *  *

// для обработки более сложных, "серьезных" ошибок более подходящим вариантом 
// будет являться соответствующий обработчик внутри init

struct Astronaut {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// name должен быть не пустой строкой и возраст должен быть в диапазоне от 18 до 70
// enum для потенциальных ошибок:

enum InvalidAstronautDataError: Error {
    case EmptyName
    case InvalidAge
}

init(name: String, age: Int) throws {
    if name.isEmpty {
        throw InvalidAstronautDataError.EmptyName
    }
    
    if age < 18 || age > 70 {
        throw InvalidAstronautDataError.InvalidAge
    }
    
    self.name = name
    self.age = age
}

let johnny = try? Astronaut(name: "Johnny Cosmoseed", age: 42)
let johnnyYoung = try? Astronaut(name: "Johnny Cosmoseed", age: 17) // nil

// резюмируя, более предпочтительным является второй способ
// failable inits проще во всех смыслах и присутствуют в языке от части потому,
// что в первых версиях swift не было throwing inits



// *  *  *  Class Inheritance and Initialization  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

// чтобы убедиться, что все свойства класса получат значения во время инициализации, в языке существует
// два основных способа: designated (обозначенные) initializers и convenience initializers

// designated инициализаторы являются главными при инициализации классов и обычно таких 
// инициализаторов немного или один, который будет являться ключевым элементом 
// в инициализации всего класса, включая цепочку суперклассов 

// каждый класс должен иметь как минимум один designated инициализатор
// в некоторых случаях это требования удовлетворяется путем наследования 
// одного или более designated инициализаторов от родительского класса

// convenience инициализаторы являются второстепенными и предоставляют возможность вызывать designated 
// инициализаторы текущего класса с какими-либо предопределенными параметрами

// они удобны в ситуациях, когда класс содержит большое кол-во различных свойств, 
// которые не всегда нужна иинициализировать все сразу 

class Movie {
    var title: String
    var director: String
    var budget: Int

    init(title: String, director: String, budget: Int) {
        self.title = title
        self.director = director
        self.budget = budget
    }

    convenience init(title: String) {
        self.init(title: title, director: "Unknown", budget: 0)
    }
    

    convenience init(title: String, director: String) {
        self.init(title: title, director: director, budget: 0)
    }
}

let theGoodTheBadTheUgly = Movie(title: "The Good, the Bad and the Ugly")
let theRevolver = Movie(title: "The Revoler", director: "Guy Ritchie")

// convenience инициализатор может так же служить для конкретного применения класса 
// или определенного входящего параметра/ов

// convenience инициализаторы не являются обязательными и используются для сокращения, а так же 
// повышения читабельности кода засчет упрощения процесса инициализации


// *  *  *  Rules  *  *  *

// A designated initializer must call a designated initializer from its immediate superclass.
// A convenience initializer must call another initializer from the same class.
// A convenience initializer must ultimately call a designated initializer.

// Designated initializers must always delegate up.
// Convenience initializers must always delegate across.

// данные правила ^ не относятся к тому, как будут создаваться экземпляры классов 
// с любым из инициализаторов (convenience или designated) можно создать полностьью 
// инициализированный экземпляр 


// *  *  *  Initializer Inheritance and Overriding  *  *  *

// в данном примере при создании экземпляров Vehicle будет создан инициализатор по умолчанию,
// который практически всегда будет являться designated инициализатор 

// default designated initializer
class Vehicle {
    var numberOfWheels = 0
    
    // computed property
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

// когда инициализатор сабкласса совпадает (по сигнатуре) с инициализатором родительского, 
// такой инициализатор необходимо записывать через модификатор override

// это актуально так же в ситуациях, когда родительский класс создается через 
// инициализатор по умолчанию (как на примере выше)

class Bicycle: Vehicle {
    // сигнатура без аргументов, так же как в Vehicle default init -> override
    override init() {
        // super - ссылка на суперкласс
        // super.init() делается для корректного наследования свойст суперкласса 
        super.init()
        numberOfWheels = 2
    }
}

// другой пример наследования 
// здесь инициализаторы не совпадают -> no need override keyword
// но видна демонстрация наследования -> переопределения свойст родителя + своих

class Main {
    var a: Int = 10
}

class Secondary: Main {
    let b: String

    init (b: String) {
        self.b = b 
        super.init()
        a = 12
    }
}

// так же хороший пример с переопределнием уже свойства, а не инициализатора 

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

// модификатор override должен быть использован так же в ситуациях, когда инициализатором 
// сабкласса выступает convenience инициализатор (в случае inits match)

// если инициализатор в сабклассе совпадает с convenience инициализатором, 
// override не указывается, так как это противоречит правилам написания инициализаторов в swift













// TODO: попрактковать все эти designated и convenience инициализаторы 

