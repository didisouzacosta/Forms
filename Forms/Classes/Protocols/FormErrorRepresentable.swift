//
//  FormErrorRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

public protocol FormErrorRepresentable: LocalizedError {}

extension String: FormErrorRepresentable {
    
    public var errorDescription: String? { return self }
    public var failureReason: String? { return errorDescription }
    
}
