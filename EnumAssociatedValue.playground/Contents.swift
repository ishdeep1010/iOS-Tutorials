import UIKit

// Enums are very powerful in swift.
// Bunch of types or cases grouped together is basically an enum.
// Enums also have a concept of associated value. You can simply give a value along with every case and do a switch case on it to retrieve it.
enum Guy {
    case age(Int)
    case someting(vc: UIViewController)
    case name
    case whatever
    
    func getAge() -> Int? {
        switch self {
            
        case .age(let age):
            return age
        case .someting(let vc):
            print(vc.view)
            return nil
        case .name:
            return nil
        case .whatever:
            return nil
        }
    }
}

let sureshAge = Guy.age(10)

//switch sureshAge {
//case .sometihn : break
//
//case .age(_):
//    <#code#>
//case .name:
//    <#code#>
//case .whatever:
//    <#code#>
//}

print(sureshAge.getAge() ?? 5)


// We can also pass around closures and get a callback again.
// Let's see an MVVM example of where it is demoed.

enum MainViewModelActions {
    
    case homeDataReceived(success:Bool, completionHandler : ((Bool) -> ()))

}


class MainHomeViewModel {
    var actionInvoked : ((MainViewModelActions) -> ())?
    func getHomeData() {
        //var params = [String:Any]()
        //params["cityId"] = "1"
        //ApiManager.shared.getRequest {
//            [weak self]
//            (success, response) in
//            if success {
//                self.actionInvoked?(.homeDataReceived(success: true, completionHandler: {bool in
//                print("controller received data if view model wants to do something now they can do. ", bool)
//            }))
//            }
//            else {
//                self.actionInvoked?(.homeDataReceived(success: true, completionHandler: {bool in
//
//            }))
//            }
//        }
    }
}


class MainHomeViewController : UIViewController {
    var viewModel = MainHomeViewModel()
    
override func viewDidLoad() {
    super.viewDidLoad()
     addBindingActions()
}
    func addBindingActions() {
        viewModel.actionInvoked = {
            [weak self]
            (action) in
            switch action {
                
            case .homeDataReceived(let success, let ch):
                if success {
                    //self?.populateData()
                    ch(true)
                }
                else {
                    // show fallback controller.
                }
            }
        }
    }
}
