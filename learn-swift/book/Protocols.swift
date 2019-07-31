// протоколы являются "чертежами" для структур данных в swift
// они описывают (без каких-либо реализаций) требования, которые 
// та или иная структура данных должна удовлетворять


// *  *  *  Property Requirements  *  *  *
// *  *  *  *  *  *  *  *  *  *  *  *  *  *

protocol FullyNamed {
    // read-only property
    var fullName: String { get }
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
  
    // computed read-only property
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")



// *  *  *  Method Requirements  *  *  *  *
// *  *  *  *  *  *  *  *  *  *  *  *  *  *

// no defaul values
// always with static keywoard
