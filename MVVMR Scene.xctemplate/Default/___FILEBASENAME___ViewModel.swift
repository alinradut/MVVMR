//___FILEHEADER___

import Foundation
import MVVMR

public struct ___VARIABLE_productName___Context = {
}

public class ___VARIABLE_productName___ViewModel: ViewModel {
    
    public var router: ___VARIABLE_productName___Router?
    
    private(set) var context: ___VARIABLE_productName___Context!

    public required init() {
        
    }

    public func setContext(_ context: ___VARIABLE_productName___Context) {
        self.context = context
    }
}
