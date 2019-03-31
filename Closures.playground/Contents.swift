import UIKit

// Closures
// Self contained blocks of functional code, which can be passed around as references.
// Basically functions are also closures.
// Functions are special category of closures having name.
// Closure expressions basically unnamed function are also closures.
// Similar to: Blocks in C ans Objective C
// Have the capability to close over - retain references to - the constants and variables, called as Closure capturing.

var array : Array<String> = ["One", "Two", "Three", "Four", "Five", "Six"]

//array.sort(by: (String, String) throws -> Bool)



func fowards(_ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}

array.sort(by: fowards)
print(array)

// References to a function can also be used

var copyFunc = fowards
array.sort(by: copyFunc)

// In Line Closure
array.sort(by: {(s1: String, s2: String) -> Bool in
    return s1 < s2
})

// Due to type inference
array.sort(by: {
    s1, s2 in
    print("asd")
    return s1 < s2
})

// Implicit return closure
array.sort(by: {s1,s2 in
    s1 < s2
})

// Shorthand Argument names
array.sort(by: {
    $0 < $1
})

// So basically < is a function with (String, String) -> Bool signature
array.sort(by: <)

// Trailing Closure, syntactical chocolate
array.sort { $0 < $1 }


// Signature Dependent
func testSum (_ first: Int, _ second: Int) -> Int {
    return first + second
}

func testSub(_ first: Int, _ second : Int) -> Int {
    return first - second
}

var testArray : Array<(Int, Int) -> Int> = []
testArray.append(testSub(_:_:))
testArray.append(testSum(_:_:))

// Capturing Values

func createIncrementorTo(IncrementBy value : Int) -> (()->Int) {
    var increment : Int = 0
    func incrementer() -> Int {
        increment += value
        return increment
    }
    return incrementer
}



// Delayed execution
