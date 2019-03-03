//
//  Form.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

public class Form: NSObject, FormRepresentable {
    
    public var sections: [FormSectionRepresentable]
    
    private weak var tableView: UITableView?

    public init(tableView: UITableView?, sections: FormSectionRepresentable...) {
        self.tableView = tableView
        self.sections = sections
        
        super.init()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
}

extension Form: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let field = sections[indexPath.section].fields[indexPath.row]
        print(field)
    }
    
}

extension Form: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].fields.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = sections[indexPath.section].fields[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: field.identifier)
        cell.textLabel?.text = field.identifier
        return cell
    }
    
}
