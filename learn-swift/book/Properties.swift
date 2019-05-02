// computed: classes, structs и enums
// stored: classes и enums

// stored и computed props обычно ассоциируются с экземпляром конкретного типа, 
// однако так же могут относиться к самому типу. Такие props называются type props

// property observer: создание реакции на измнение значения одного из свойств
// такие observers могут быть добавлены к созданным stored props, а так же
// к наследуемым properties


// *  *  *  lazy stored props  *  *  *
// lazy stored props - такие свойства, начальные значения которых не будут  
// вычисляться до первого обращения

// Важно понимать, что константы всегда получают значение до окончания
// init, в то время как lazy stored prop может может оставаться 
// без него и после окончания init -> lazy VAR myLazyProp

// lazy props полезны, когда начальные значение для свойств зависят от 
// внешних факторов, и могут быть неизвестны на момент окончания init
// Они так же полезны в ситуациях, когда начальное значение свойства 
// предполагает комплексные операции, требующие значительных ресурсов и 
// вычисление которых не следует выполнять до момента прямой надобности 

// Некий класс для импорта данных из файла, который
// предполагает неопределенное кол-во времени для свой инициализации
class DataImporter {
  var filename = "data.txt"
  // ... do stuff
}

class DataManager {
  lazy var importer = DataImporter()
  // ... do stuff
}

// Здесь, для функционирования экземпляра manager, ему вовсе необходимо изначально
// инициализировать сво-во importer
let manager = DataManager()

// но затем, когда оно понадобиться, произойдет непосредственно инициализация
// при обращении к свойству
let filename = manager.importer.filename


// *  *  *  Observ  *  *  *
// это разве то же самое что и obser? 
// Хороший приемер - когда при изменении одного из полей ну
    var paymentId: String? {
        get {
            return contentView.paymentIdTextField.textField.text
        }
        
        set {
            contentView.paymentIdTextField.textField.text = newValue
        }
    }

