//___FILEHEADER___

import Foundation
import MVVMR

public struct ___VARIABLE_productName___Router: Router {
    
    /// The controller this router and it's related view controller were presented on.
    public weak var parentController: UIViewController?
    
    /// The incoming transition that was used to display this scene. We keep a reference because
    /// we might want to reverse that transition at one point.
    public var presentationTransition: Transition?
    
    typealias R = Routes
    
    enum Routes: Route {
        func navigate(on parentController: UIViewController?) {
            switch self {
            
            default:
                break
            }
        }
    }
    
    public init() {}
}
