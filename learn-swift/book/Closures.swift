// замыкания в swift - это блоки кода, которые можно назначать
// переменным, а так же использовать в качестве лямбда выражений

// глобальные и вложенные функции являются частными случаями замыканий, но
// существуют так же closure expression, которые представляют собой упрощенный
// синтаксис и могут захватывать переменные из вне


let noParameterAndNoReturnValue: () -> () = {
    print("Hey")
}

let noParameterAndNoReturnValueSimplified = {
    print("Hey")
}


let noParameterAndReturnValue: () -> String = {
    return "Hello"
}

let noParameterAndReturnValueSimplified = { () -> String in
    return "Hello"
}


let oneParameterAndReturnValue: (Int) -> Int = { x in
    return x + 10
}

let oneParameterAndReturnValueSimplified = { (x: Int) -> Int in
    return x + 10
}

let oneParameterAndReturnValueShortand: (Int) -> Int = {
    return $0 + 10
}


let multipleParametersAndReturnValue: (Int, Int) -> Int = { (a, b) in
    return a + b
}

let multipleParametersAndReturnValueSimplified = { (a: Int, b: Int) -> Int in
    return a + b
}

let multipleParametersAndReturnValueShortand: (Int, Int) -> Int = {
    return $0 + $1
}

