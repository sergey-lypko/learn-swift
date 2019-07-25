// https://docs.swift.org/swift-book/LanguageGuide/Initialization.html

// основная задача инициализаторов убедиться в том, что новые экземпляры 
// создаются корректно перед тем как они будут впервые использованы (с точки зрения их props)


// *  *  *  Значения по-умолчанию  *  *  *
// *  *  *  *  *  *  *  *  *  *  *  *  *  *

// если свойство всегда получает одно и то же значение, следует передавать его 
// как значение по-умолчанию при объявлении свойства, нежели через инициализатор

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

// memberwise initializer - это упрощенный способ создания экземпляров структур

struct Size {
    var width = 0.0, height = 0.0
}

// значения в свойства записываются через имена соответственно
let couple = Size(width: 2, height: 2)

// в том случае, если у свойства уже есть значения по умолчанию, его можно пропустить при
// инициализации структуры



// *  *  *  Initializer Delegation (value type > struct/enum)  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

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



// *  *  *  Class Inheritance and Initialization  *  *  * 
// *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *

// чтобы убедиться, что все свойства класса получат значения во время инициализации, в языке существует
// два основных способа: designated (обозначенные) initializers и convenience initializers

// designated инициализаторы являются главными при инициализации классов и обычно таких 
// инициализаторов не много или один, который будет являться ключевым элементом 
// в инициализации всего класса, включая цепочку суперклассов 

// каждый класс должен иметь как минимум один designated инициализатор
// в некоторых случаях это требования удовлетворяется путем наследования 
// одного или более designated инициализаторов от родительского класса

// convenience инициализаторы являются второстепенными и предоставляют возможность вызывать designated 
// инициализаторы текущего класса с какими-либо предопределенными параметрами

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


// * . * . * . Initializer Inheritance and Overriding  * . * . *












// TODO: попрактковать все эти designated и convenience инициализаторы 

