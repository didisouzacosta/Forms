//
//  Form.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

import UIKit

public class Form: NSObject, FormRepresentable {
    
    // MARK: - Public Variables
    
    public weak var tableView: UITableView?
    
    // MARK: - Private Variables
    
    private var isRegisteredCells: Bool = false
    
    // MARK: - Life Cycle
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 54.0
    }
    
    private func registerCells() {
        guard isRegisteredCells == false else { return }
        
        sections.flatMap { $0.fields }.forEach { [weak tableView] field in
            tableView?.register(field.nib, forCellReuseIdentifier: field.cellIdentifier)
        }
        
        isRegisteredCells = true
    }
    
}

extension Form: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FormFieldCellSelectable else { return }
        cell.handler()
        tableView.deselectRow(at: indexPath, animated: true)
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
        registerCells()
        let field = sections[indexPath.section].fields[indexPath.row]
        return tableView.dequeueReusableCell(with: field, indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension UITableView {
    
    func dequeueReusableCell(with field: FormFieldRepresentable, indexPath: IndexPath) -> FormCell {
        guard let cell = dequeueReusableCell(withIdentifier: field.cellIdentifier, for: indexPath) as? FormCell else {
            fatalError("Cell not corresponds of type 'FormCell'.")
        }
        cell.setup(with: field)
        return cell
    }
    
}
