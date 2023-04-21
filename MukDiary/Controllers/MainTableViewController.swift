//
//  MainTableViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import UIKit
import UITextView_Placeholder

class MainTableViewController: UITableViewController {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        
        return f
    }()
    
    @IBOutlet weak var emptyCheckLabel: UILabel!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.shared.fetchDiary()
        
        if DataManager.shared.diaryList.isEmpty {
            emptyCheckLabel.isHidden = false
        } else {
            emptyCheckLabel.isHidden = true
        }
       
        tableView.reloadData()
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.diary = DataManager.shared.diaryList[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: ComposeViewController.newDiaryDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.tableView.reloadData()
        }
        
        OptionViewController().checkSwitchState()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.diaryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        
        let target = DataManager.shared.diaryList[indexPath.row]
        
        cell.textLabel?.text = target.title
        cell.textLabel?.textColor = UIColor(named: "MukLabelColor")
        cell.detailTextLabel?.text = formatter.string(for: target.insertDate)
        
        return cell
    }

    
}
