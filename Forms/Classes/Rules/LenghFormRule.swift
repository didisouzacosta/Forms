//
//  LenghFormRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public class MinLenghFormRule: BaseFormRule<CountRepresentable> {
    
    private let min: CountRepresentable
    
    public init(min: CountRepresentable, message: String) {
        self.min = min
        super.init(message: message)
    }
    
    @discardableResult
    public override func validate(_ value: CountRepresentable?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount < min.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}

public class MaxLenghFormRule: BaseFormRule<CountRepresentable> {
    
    private let max: CountRepresentable
    
    public init(max: CountRepresentable, message: String) {
        self.max = max
        super.init(message: message)
    }
    
    @discardableResult
    public override func validate(_ value: CountRepresentable?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount > max.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}

public class ExactLenghFormRule: BaseFormRule<CountRepresentable> {
    
    private let exactLenght: CountRepresentable
    
    public init(exactLenght: CountRepresentable, message: String) {
        self.exactLenght = exactLenght
        super.init(message: message)
    }
    
    @discardableResult
    public override func validate(_ value: CountRepresentable?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount != exactLenght.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}
