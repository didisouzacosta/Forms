//
//  LenghFormRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public struct MinLenghFormRule: FormRuleRepresentable {
    
    public typealias RuleValueType = CountRepresentable
    
    public var message: String
    
    private let min: RuleValueType
    
    init(min: RuleValueType, message: String) {
        self.min = min
        self.message = message
    }
    
    public func validate(_ value: RuleValueType?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount < min.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}

public struct MaxLenghFormRule: FormRuleRepresentable {
    
    public typealias RuleValueType = CountRepresentable
    
    public var message: String
    
    private let max: RuleValueType
    
    init(max: RuleValueType, message: String) {
        self.max = max
        self.message = message
    }
    
    public func validate(_ value: RuleValueType?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount > max.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}

public struct ExactLenghFormRule: FormRuleRepresentable {
    
    public typealias RuleValueType = CountRepresentable
    
    public var message: String
    
    private let exactLengh: RuleValueType
    
    init(exactLengh: RuleValueType, message: String) {
        self.exactLengh = exactLengh
        self.message = message
    }
    
    public func validate(_ value: RuleValueType?) throws -> Bool {
        guard let value = value else { return true }
        
        if value.valueCount != exactLengh.valueCount {
            throw message
        } else {
            return true
        }
    }
    
}
