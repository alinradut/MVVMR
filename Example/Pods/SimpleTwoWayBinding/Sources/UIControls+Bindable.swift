//
//  UIControls+Bindable.swift
//  SimpleTwoWayBinding
//
//  Created by Manish Katoch on 11/26/17.
//

import Foundation

extension UITextField : Bindable {
    public typealias BindingType = String
    
    public func observingValue() -> String? {
        return self.text
    }
    
    public func updateValue(with value: String) {
        if self.text != value {
            self.text = value
        }
    }
}

extension UISwitch : Bindable {
    public typealias BindingType = Bool
    
    public func observingValue() -> Bool? {
        return self.isOn
    }
    
    public func updateValue(with value: Bool) {
        self.isOn = value
    }
}

extension UISlider : Bindable {
    public typealias BindingType = Float
    
    public func observingValue() -> Float? {
        return self.value
    }
    
    public func updateValue(with value: Float) {
        self.value = value
    }
}

extension UIStepper : Bindable {
    public typealias BindingType = Double
    
    public func observingValue() -> Double? {
        return self.value
    }
    
    public func updateValue(with value: Double) {
        self.value = value
    }
}

extension UISegmentedControl : Bindable {
    public typealias BindingType = Int
    
    public func observingValue() -> Int? {
        return self.selectedSegmentIndex
    }
    
    public func updateValue(with value: Int) {
        self.selectedSegmentIndex = value
    }
}

public class BindableTextView: UITextView, Bindable, UITextViewDelegate {
    public typealias BindingType = String
    
    public func observingValue() -> String? {
        return self.text
    }
    
    public func updateValue(with value: String) {
        if self.text != value {
            self.text = value
        }
    }
    
    public func bind(replay: Bool = false, with observable: Observable<String>) -> BindingReceipt {
        self.delegate = self
        self.register(for: observable)
        let r = self.observe(for: observable) { [weak self] (value) in
            self?.updateValue(with: value)
        }
        if let s = observable.value {
            DispatchQueue.main.async { [weak self] in
                self?.updateValue(with: s)
            }
            
        }
        return r
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.valueChanged()
    }
}

extension UILabel: Bindable {
    public typealias BindingType = String
    public func observingValue() -> String? { text }
    public func updateValue(with value: String) { text = value }
}
