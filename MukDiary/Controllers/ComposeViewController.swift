//
//  ComposeViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var editTarget: Diary?

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
            // 일기 편집 모드
        if let target = editTarget {
            target.title = diaryTitle
            target.content = diaryContent
            
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.diaryDidChanged, object: nil)
        } else { // 새 일기 쓰기 모드
            DataManager.shared.addNewDiary(diaryTitle: diaryTitle, diaryContent: diaryContent)
            NotificationCenter.default.post(name: ComposeViewController.newDiaryDidInsert, object: nil)
        }
        
        
        
        
        dismiss(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let diary = editTarget {
            navigationItem.title = "일기 편집"
            titleTextView.text = diary.title
            contentTextView.text = diary.content
        } else {
            navigationItem.title = "새 일기"
            titleTextView.text = ""
            contentTextView.text = ""
        }
    }

}

extension ComposeViewController {
    static let newDiaryDidInsert = Notification.Name(rawValue: "newDiaryDidInsert")
    static let diaryDidChanged = Notification.Name(rawValue: "diaryDidChanged")
}
