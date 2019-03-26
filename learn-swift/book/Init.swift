// различные инициализаторы
struct Temperature {
    var temperature: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperature = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperature = kelvin - 273.15
    }
}

let fahrenheitTemperature = Temperature(fromFahrenheit: 212.0)
let kelvinTemperature = Temperature(fromKelvin: 273.15)
