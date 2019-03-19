//
//  LenghFormRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public class MinLenghFormRule: BaseFormRule<Countable> {
    
    private let min: Countable
    
    public init(min: Countable, message: String) {
        self.min = min
        super.init(message: message)
    }
    
    @discardableResult
    public override func validate(_ value: Countable?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount < min.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}

public class MaxLenghFormRule: BaseFormRule<Countable> {
    
    private let max: Countable
    
    public init(max: Countable, message: String) {
        self.max = max
        super.init(message: message)
    }
    
    @discardableResult
    public override func validate(_ value: Countable?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount > max.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}

public class ExactLenghFormRule: BaseFormRule<Countable> {
    
    private let exactLenght: Countable
    
    public init(exactLenght: Countable, message: String) {
        self.exactLenght = exactLenght
        super.init(message: message)
    }
    
    @discardableResult
    public override func validate(_ value: Countable?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount != exactLenght.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}
