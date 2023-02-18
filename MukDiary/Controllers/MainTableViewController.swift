//
//  MainTableViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataManager.shared.diaryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)

        let target = DataManager.shared.diaryList[indexPath.row]
        
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = formatter.string(for: target.insertDate)

        return cell
    }

    
}
