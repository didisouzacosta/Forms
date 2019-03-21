//
//  SectionForm.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

public final class SectionForm: FormSectionProtocol {
    
    public var title: String? = nil
    public var footer: String? = nil
    public var headerView: UIView? = nil
    public var footerView: UIView? = nil
    
    public init(title: String? = nil, headerView: UIView? = nil, footer: String? = nil, footerView: UIView? = nil) {
        self.title = title
        self.headerView = headerView
        self.footer = footer
        self.footerView = footerView
    }
    
}
