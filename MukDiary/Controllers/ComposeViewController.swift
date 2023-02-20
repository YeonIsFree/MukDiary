//
//  ComposeViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let diaryTitle = titleTextView.text, diaryTitle.count > 0 else {
            alert(message: "제목을 입력하세요")
            return
        }
        
        guard let diaryContent = contentTextView.text, diaryContent.count > 0 else {
            alert(message: "내용을 입력하세요")
            return
        }
        
        let newDiary = tmpData(tmpTitle: diaryTitle, tmpContent: diaryContent)
        
        tmpDataArray.append(newDiary)
        
        NotificationCenter.default.post(name: ComposeViewController.newDiaryDidInsert, object: nil)
        
        dismiss(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ComposeViewController {
    static let newDiaryDidInsert = Notification.Name(rawValue: "newDiaryDidInsert")
}
