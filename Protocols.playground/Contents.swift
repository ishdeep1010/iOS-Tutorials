import UIKit

// Reasons to use protocols.
// If you want to give different implementations for different properties and methods go for Protocols. Protocols can be used as types can be put in an array, same variable can be used for different classes or structs or enums that conform to the protocol.
// Classes are great, have inheritance, encapsulation, abstraction, access specifiers, computed properties, overriding. The very idea of objects arise from them. Heck Java is all classes.
// But there are limitations.
// 1) The problem of implicit sharing, Suppose there is a class A has some data called someObject in it. class B wants to inherit from A so it automatically gets the data someObject in it. Everything was working fine B was also using that someObject as expected, then some time later in the app lifecycle A changed the data to some other data, now B's someObject is also changed because its pass by reference, and B does not behave as expected. Not good for B at all, so in order to solve this we either copy or use thread locks, which means more complex code prone to situations like deadlock and slower code running and ultimately BUGS :/
// 2) Only 1 superclass is possible, there is no concept of multiple inheritance in Swift. There is an overhead while initializing classes, also while just using classes in general. Compiler adds the code to check for overrides and super classes/ sub classes. Also there is ambiguity on what you want to override.
// 3) Lost Type Relationship. Will be explained in next session.


// Taken from Stanford Video Lectures, go through it. PROTOCOL AS A TYPE
protocol Moveable {
    func move(to point: CGPoint)
}

class Car: Moveable {
    func move(to point: CGPoint) {
        
    }
}

struct Shape: Moveable {
    func move(to point: CGPoint) {
        
    }
    
    
}

var thingToMove : Moveable = Car.init()
thingToMove = Shape.init()
var square = Shape.init()
var honda = Car.init()
var thingsToMove : [Moveable] = [square,honda]
thingsToMove[0].move(to: CGPoint.init(x: 0, y: 0))
func slide(slider: Moveable) {
    slider.move(to: CGPoint.init(x: 0, y: 0))
}

protocol Slippery {
    func Slipping()
}

class Nano : NSObject,Moveable, Slippery {
    func Slipping() {
        
    }
    
    func move(to point: CGPoint) {
        
    }
    
    
}

func slipAndSlide(x: Slippery & Moveable) {
    x.Slipping()
    x.move(to: CGPoint.init(x: 0, y: 0))
}

slipAndSlide(x: Nano())
//slipAndSlide(x: honda)


// A protocol employee. With some basic things.
protocol employee {
    var name : String? { get }
    mutating func salary() -> Int
}

// protocol inheritance. If you are a part of iOSTeam you are automatically an employee.
protocol iOSTeam : employee{
    func hasSwag(a: Int,b: Int) -> Bool
    func performTask()
}

// An extension to an employee. Also giving an optional method.
extension employee {
    var basicSalary : Int? {
        get {
            return 10000
        }
        set {
            // Note : In Set you can never set the particular computed property, it would obviously be an infinite loop.
            //basicSalary = 100
        }
    }
    
    func optinalMethod() {
        
    }
}


protocol otherTeam :  employee {
    var floorNumber : Int? {get}
}

protocol teamLead : employee {
    func numberOfPeopleUnder() -> Int
}

// Note : how the intern is not considered as an employee and the kind of flexibility it will further give.
@objc protocol intern {
    func numberOfMonths() -> Int
}

// Some important default implementation.
extension iOSTeam {
    func isIntelligent(name : String?) -> Bool{
        var isIntelligent = false
        if let name = name {
            if name == "Hoshiyaar" {
                isIntelligent = true
            }
            else {
                isIntelligent = false
            }
        }
        return isIntelligent
    }
}


class Ishdeep : iOSTeam {
    
    var name: String?
    
    init(name : String) {
        self.name = name
    }
    
    func salary() -> Int {
        return basicSalary ?? 1000
    }
    
    func hasSwag(a : Int, b : Int) -> Bool {
        let a = a
        let b = b
        if a + b == 30 {
            return true
        }
        else {
            return false
        }
    }
    
    func performTask() {
        
    }
}

var ish = Ishdeep(name: "Ishdeep")

print(ish.isIntelligent(name: ish.name))

print(ish is teamLead)

print(ish is iOSTeam)

print(ish.hasSwag(a: 10,b: 20))

print(ish.salary())

ish.performTask()


struct Iyer : otherTeam,teamLead {
    var name: String?
    var floorNumber: Int?
    
    //var age: Int?
    mutating func salary() -> Int {
        basicSalary = 5000
        return basicSalary!*30
    }
    
    func numberOfPeopleUnder() -> Int {
        // some logic
        return 10
    }
}

enum hrGuy : employee {
    var name: String? {
        get {
            return "hr"
        }
    }
    func salary() -> Int {
        return 5
    }
}
