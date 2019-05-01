// основная задача инициализаторов убедиться в том, что новые экземпляры 
// создаются корректно перед тем как они будут впервые использованы


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

// основнной способ, с помощью которого swift определяе какой init  
// использовать - это аргументы и их имена
let fahrenheitTemperature = CelsiusTemperature(fromFahrenheit: 212.0)
let kelvinTemperature = CelsiusTemperature(fromKelvin: 273.15)
let baseTemperature = CelsiusTemperature(36.6)


// *  *  *  Умная инициализация у структур  *  *  * 
struct Size {
    var width = 0.0, height = 0.0
}

// не смотря на то, что внутри структуры не было объявлено явных 
// инициализаторов, при создании экземпляра есть возможность 
// передать аргументы через имена
let couple = Size(width: 2, height: 2)
