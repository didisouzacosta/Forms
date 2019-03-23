//
//  Form.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

import UIKit

public class Form: NSObject, FormProtocol {
    
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
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.headerView != nil || section.title != nil ? UITableView.automaticDimension : 0.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = sections[section]
        let footerSpacing: CGFloat = section.title == nil && section.headerView == nil ? 20.0 : 0.0
        return section.footerView != nil || section.footer != nil ? UITableView.automaticDimension : footerSpacing
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return sections[section].footerView ?? UIView()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].fields.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = sections[indexPath.section].fields[indexPath.row]
        return tableView.dequeueFormCell(with: field, indexPath: indexPath)
    }
    
}

extension UITableView {
    
    func dequeueFormCell(with field: FormFieldProtocol, indexPath: IndexPath) -> FormCell {
        let cell = dequeueReusableCell(withIdentifier: field.cellIdentifier, for: indexPath) as! FormCell
        cell.setup(with: field)
        return cell
    }
    
}
