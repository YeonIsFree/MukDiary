//
//  DetailViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    // 이전 화면에서 넘어온 Diary 객체를 이 변수에 저장한다.
    var diary: Diary?
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        
        return f
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            cell.textLabel?.text = diary?.title
            return cell
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: diary?.insertDate)
            return cell
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)
            cell.textLabel?.text = diary?.content
            return cell
        default:
            fatalError()
        }
    }
    
    
}
