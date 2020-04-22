//
//  SettingsViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 21/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController {
    
    // MARK: - Fields
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = UIColor.white
        configureUI()

        // Do any additional setup after loading the view.
    }
     // MARK: - Helper Functions
        
        func configureTableView() {
            tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            
            tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
            view.addSubview(tableView)
            tableView.frame = view.frame
            
            tableView.tableFooterView = UIView()
        }
        
        func configureUI() {
            configureTableView()
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.barTintColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
            
            navigationItem.title = "Indstillinger"
        }
       

    }



extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Social: return GeneralOptions.allCases.count
        case .Communications: return CommuncationOptions.allCases.count
        case .Information: return InformationOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let title = UILabel()
        title.text = SettingsSection(rawValue: section)?.description
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = .white
        view.backgroundColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Social:
            let social = GeneralOptions(rawValue: indexPath.row)
            cell.sectionType = social
        case .Communications:
            let communications = CommuncationOptions(rawValue: indexPath.row)
            cell.sectionType = communications
        case .Information:
            let information = InformationOptions(rawValue: indexPath.row)
            cell.sectionType = information
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let section = SettingsSection(rawValue: indexPath.section) else { return}
    
        switch section {
        case .Social:
            if indexPath.row == 0 {
                pushViewController(SettingsLocationViewController())
            }
            else {
                pushViewController(SettingsMapViewController())
            }
        case .Communications:
            print("Test")

        case .Information:
        switch indexPath.row {
            case 0: pushViewController(SettingsAboutViewController())
            case 1: pushViewController(SettingsReportViewController())
            case 2: pushViewController(SettingsFAQViewController())
            case 3: pushViewController(SettingsHelpViewController())
            default:
                print("ERROR")
            }

        }
    }
    
    private func pushViewController(_ viewController: UIViewController){
        viewController.view.backgroundColor = .white
        navigationController?.pushViewController(viewController, animated: true)
    }
        
        
}
