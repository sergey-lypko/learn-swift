import UIKit


//class Person {
//    let name: String
//    let age: Int
//    let handler: () -> Void
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coll = [1, 2, 3, 4, 5, 6]
        
        let collSum = coll.reduce(10, {a, b in
            return a + b
        })
        
        print(collSum)
    }
}

