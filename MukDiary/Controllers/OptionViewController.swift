//
//  OptionViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/21.
//

import UIKit

class OptionViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    let onOffKey = "onOffKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSwitchState()
    }
    
    // MARK: - Dark Mode
    
    var darkModeSwitch: UISwitch = {
        var modeSwitch = UISwitch()
        modeSwitch.addTarget(nil, action: #selector(modeSwitchTapped), for: .touchUpInside)
        return modeSwitch
    }()

    @objc func modeSwitchTapped(_ sender: UISwitch) {
        let appDelegate = UIApplication.shared.windows.first
        if sender.isOn {
            appDelegate?.overrideUserInterfaceStyle = .dark
            userDefaults.set(true, forKey: onOffKey)
            
        } else {
            appDelegate?.overrideUserInterfaceStyle = .light
            userDefaults.set(false, forKey: onOffKey)
        }
    }
    
    func checkSwitchState() {
        let appDelegate = UIApplication.shared.windows.first
        if(userDefaults.bool(forKey: onOffKey)) {
            darkModeSwitch.setOn(true, animated: false)
            appDelegate?.overrideUserInterfaceStyle = .dark
        } else {
            darkModeSwitch.setOn(false, animated: false)
            appDelegate?.overrideUserInterfaceStyle = .light
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "versionCell", for: indexPath)
            cell.textLabel?.text = "버전 정보"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "devCell", for: indexPath)
            cell.textLabel?.text = "개발자 정보"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "darkModeCell", for: indexPath)
            cell.textLabel?.text = "다크 모드"
            cell.accessoryView = darkModeSwitch
            return cell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if indexPath.row == 1 {
            devAlert(message: "Yeon \n seryun91@naver.com")
        }
    }
    

}
