//
//  String+Error.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

extension String: LocalizedError {
    
    public var errorDescription: String? { return self }
    public var failureReason: String? { return errorDescription }
    
}
