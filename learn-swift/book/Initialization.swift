// основная задача инициализаторов убедиться в том, что новые экземпляры 
// создаются корректно перед тем как они будут впервые использованы (с точки зрения их props)


// *  *  *  Различные инициализаторы  *  *  *
struct CelsiusTemperature {
    var temperature: Double
    
    init(fromFahrenheit: Double) {
        temperature = (fromFahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin: Double) {
        temperature = fromKelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperature = celsius
    }
    
    init()
}

// основнной способ, с помощью которого swift определяет какой init  
// использовать - это аргументы и их именами
let fahrenheitTemperature = CelsiusTemperature(fromFahrenheit: 212.0)
let kelvinTemperature = CelsiusTemperature(fromKelvin: 273.15)
let baseTemperature = CelsiusTemperature(36.6)


// *  *  *  Значения по-умолчанию  *  *  *
// если свойство всегда получает одно и то же значение, следует передавать его 
// как значение по-умолчанию при объявлении свойства, нежели через инициализатор
// конечный результат один и тот же, однако при объявлении значения по-умолчанию, 
// передаваемое значение связывается со свойством более тесно (с точки зрения реализации языка)
// значения по-умолчанию так же способствуют более удобному пострению наследований 
// и связанными манипуляциями над свойствами объектов 
struct Car {
    let wheelsAmount: Int = 4
    var model: Model
    
    init(model: Model) {
        self.model = model
    }
}


// *  *  *  Struct Memberwise Initializers  *  *  * 
struct Size {
    var width = 0.0, height = 0.0
}

// не смотря на то, что внутри структуры не было объявлено явных 
// инициализаторов, при создании экземпляра есть возможность 
// передать аргументы через имена (Memberwise Initializers)
let couple = Size(width: 2, height: 2)



// *  *  *  Initializer Delegation  *  *  * 
// Одни инициализаторы могут вызывать другие, чтобы выполнить часть 
// инициализации экземпляра. Этот процесс называется делегированием 
// инициализаторов и служит для избежания дублирования когда среди инициализаторов

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
        
        // обращение к одному из init через self.init
        self.init(engineType: .superEngine)
    }
}

var defaultCar = SuperCar()
var hybridCar = SuperCar(engineType: .hybrid)
var superCar = SuperCar(superEngineFirstType: .disel, superEngineSecondType: .electro)

print(defaultCar.car) // Car(engineType: CarEngineType.petrol)
print(hybridCar.car) // Car(engineType: CarEngineType.hybrid)
print(superCar.car) // Car(engineType: CarEngineType.superEngine)
