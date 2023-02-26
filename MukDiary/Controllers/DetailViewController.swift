//
//  DetailViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var diaryTableView: UITableView!
    
    // 이전 화면에서 넘어온 Diary 객체를 이 변수에 저장한다.
    var diary: Diary?
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "삭제 확인", message: "일기를 삭제할까요?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제", style: .destructive) {
            [weak self] (action) in DataManager.shared.deleteDiary(self?.diary)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        return f
    }()
    
    // 수정 화면으로 데이터 넘겨주는 부분
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = diary
        }
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: ComposeViewController.diaryDidChanged, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in self?.diaryTableView.reloadData()})

    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            cell.textLabel?.text = diary?.title
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: diary?.insertDate)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoTableViewCell
            
            if let img = diary?.photo {
                cell.photoImageView.image = UIImage(data: img)
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath)
            cell.textLabel?.text = diary?.content
            return cell
        default:
            fatalError()
        }
    }
    
    
}
