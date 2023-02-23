//
//  OptionViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/21.
//

import UIKit

class OptionViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Dark Mode
    
    var darkModeSwitch: UISwitch = {
        var modeSwitch = UISwitch()
        modeSwitch.addTarget(self, action: #selector(modeSwitchTapped), for: .touchUpInside)
        return modeSwitch
    }()

    @objc func modeSwitchTapped(_ sender: UISwitch) {
        let appDelegate = UIApplication.shared.windows.first
        if sender.isOn {
            appDelegate?.overrideUserInterfaceStyle = .dark
        } else {
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
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "gearshape")
            content.text = "버전 정보"
            cell.contentConfiguration = content
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "devCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "person")
            content.text = "개발자 정보"
            cell.contentConfiguration = content
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "darkModeCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "moon")
            content.text = "다크 모드"
        
            cell.accessoryView = darkModeSwitch
            
            cell.contentConfiguration = content
            
            return cell
        default:
            fatalError()
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
