import UIKit

import UIKit


var stringArr = ["yo","do","lo"]
var intArr = [1,2,3,4]
var doubleArr = [1.2,2.3,1.0]
// Multple methods need to be written if we do not use generics for a task as simple as printing
func printStringFromArray(arr : [String]) {
    for s in arr {
        print(s)
    }
}

func printIntFromArray(arr : [Int]) {
    for i in arr {
        print(i)
    }
}
// for double

// Simple generic method to print elements in an array.
func printElementFromArray<Element>(a:[Element]) {
    for element in a {
        print(element)
    }
}
// Can pass any type of array, but note It should have same type
printElementFromArray(a: stringArr)
printElementFromArray(a: intArr)


// Simple Example for using Generics in struct.
struct GenericArray<T> {
    var items : [T]?
    mutating func push(item : T) {
        if items != nil {
            items?.append(item)
        }
        else {
            items = [T]()
            items?.append(item)
        }
    }
}

var peeps : GenericArray<String> = GenericArray.init(items: ["do", "lo"])

peeps.push(item: "yo")
peeps.push(item: "mo")

print(peeps)

//Note Error : Cannot convert value of type 'GenericArray<Any>' to specified type 'GenericArray<String>'
//var generic : GenericArray<String> = GenericArray.init(items: ["",5])
var gg = GenericArray.init(items: ["",5])   // Note : Type is GenericArray<Any>

protocol ExplainGenerics {
    func implementMeForSure()
}

extension ExplainGenerics {
    func implementMeIfYouWantTo() {
        
    }
}


struct lol : ExplainGenerics {
    func implementMeForSure() {
        
    }
}

struct troll : ExplainGenerics {
    func implementMeForSure() {
        
    }
    
    
}

class yolo : ExplainGenerics {
    func implementMeForSure() {
        
    }
}

var lolObject = lol.init()
var trollObject = troll.init()
var yoloObject = yolo()
var lolObject2 = lol()

//
func testLOL<T:ExplainGenerics>(first:T,second:T){
    
}

//Note : Error : Argument type 'lol.Type' does not conform to expected type 'ExplainGenerics'
//testLOL(first: lol, second: trollObject)
testLOL(first: lolObject, second: lolObject)

// Note how everything else was possible.
var genericProtocolArray : GenericArray<ExplainGenerics> = GenericArray.init(items : [lolObject,trollObject,yoloObject])


var arr : [ExplainGenerics] = [lolObject,trollObject]

var arr1 : Array<ExplainGenerics> = [lolObject,trollObject]



print(genericProtocolArray)



// More on Self Requirement
protocol GenericSelfProtocol {
    func doThings(with : Self)
    
}

class SomeClass: GenericSelfProtocol {
    func doThings(with: SomeClass) {
        
    }
}

class SomeOtherClass : GenericSelfProtocol {
    func doThings(with: SomeOtherClass) {
        
    }
    // Note the definition of Self
//    func doThings(with: SomeClass) {
//
//    }
}

// Note the error : Protocol 'GenericSelfProtocol' can only be used as a generic constraint because it has Self or associated type requirements
//
//func doSomeThings(with : GenericSelfProtocol) {
//
//}
// Homogeneous
// Reason : First of all the type with generic is associated at compile time. It is obviously apple's implementation to do things in this way, otherwise a downcast would have been necessary in order to use the protocols. Protocols are useless if we don't downcast them to actual types. Also the compiler knows that Self requirement or associated value exists in the protocol and it can take any type and generics is a clean way to implement the same, so compiler forces us to change the code to a generic one.
func doSomeThings<T: GenericSelfProtocol>(with someone: T, and other: T) {
    someone.doThings(with: other)
//    other.doThings(with: someone)
    
}

var someClassObj = SomeClass()
var someOtherClassObj = SomeOtherClass()
// Cannot convert value of type 'SomeOtherClass' to expected argument type 'SomeClass'
doSomeThings(with: someClassObj, and: someClassObj)



// Note how it works in terms of class.
class P{
    func printP(){
        //something
    }
}

class c:P{
    override func printP() {
        
    }
    func printC(){
        //something
    }
}
class d:P{
    override func printP() {
        
    }
    func printD(){
        //something
    }
}

// It takes P as the gnereic argument
func someTestOnC<T : P>(c:T,d:T) {

    c.printP()
    
}
// Can have heterogeneous
someTestOnC(c: d(), d: c())



// The apple example on self requirement.

protocol Ordered {
    func preceds(other:Self)->Bool
}

struct Number:Ordered {
    
    var value:Double = 0
    func preceds(other: Number) -> Bool {
        return self.value < other.value
    }
}

extension String :Ordered {
    func preceds(other: String) -> Bool {
        return self > other
    }
}

extension Double :Ordered {
    func preceds(other: Double) -> Bool {
        return self > other
    }
}

func binarySearch<T:Ordered>(sortedKeys:[T],forKey k:T)->Int {
    var lo = 0
    var hi = sortedKeys.count
    while hi > lo {
        let mid = lo  + (hi - lo) / 2
        if sortedKeys[mid].preceds(other: k) {
            lo = mid + 1
        }else{
            hi = mid
        }
    }
    return lo
}
let number = Number(value: 11.0)
binarySearch(sortedKeys: [1.0,2.0,3.0], forKey: 1.0)

// Note : Protocols can have associatedtypes
protocol associated {
    associatedtype Model
    func performTask(with : Model)
}

class A : associated{
    typealias Model = String
    
    func performTask(with: String) {
        
    }
}

class B : associated {
    typealias Model = A
    func performTask(with: A) {
        
    }
}

// Note Error : Protocol 'associated' can only be used as a generic constraint because it has Self or associated type requirements

//func whatever(type : associated) {
//
//}

// Note : here T can only be of the type UIViewController.
class  gne1 <T:UIViewController> {
    func sad(with : T) -> T {
        with.viewDidLoad()
        return with
    }
}
//var g = gne1<UIViewController>.init()
//print(g)
//class gen2 <T:gne1<G>> {
//
//}

//var ins1 = gne1<Int>.init()
//var ins2 = gne1<String>()

//var ge2 = gen2.init()
//print(ge2)
//print(ins2)
