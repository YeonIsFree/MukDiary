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
        f.dateStyle = .long
        f.timeStyle = .short
        
        return f
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataManager.shared.fetchDiary()
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
            
            // 현재 배열의 행을 목적지인 디테일 뷰 컨트롤러의 diary 변수에 넘겨준다.
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

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataManager.shared.diaryList.count
//        return DataManager.shared.diaryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        
        let target = DataManager.shared.diaryList[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = target.title
        content.secondaryText = formatter.string(for: target.insertDate)

        cell.contentConfiguration = content

        return cell
    }

    
}
