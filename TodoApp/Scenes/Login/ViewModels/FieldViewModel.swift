//
//  FieldViewModel.swift
//  RxUserLogin
//
//  Created by ALEMDAR on 18.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol FieldViewModel {
    
    // Observables
    var value: BehaviorRelay<String> { get set }
    var errorValue: BehaviorRelay<String?> { get set }
    
    var title: String { get }
    var errorMessage: String { get }

    // Validation
    func isValid() -> Bool
    
}

extension FieldViewModel {
    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
