//
//  ComposeViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import UIKit
import UITextView_Placeholder

class ComposeViewController: UIViewController, UINavigationControllerDelegate {
    
    var editTarget: Diary?
    
    @IBOutlet weak var photoView: UIImageView!
    
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
        
        guard let diaryPhoto = photoView.image?.jpegData(compressionQuality: 1.0) else {
            alert(message: "사진을 선택하세요")
            return
        }
        
        guard let diaryContent = contentTextView.text, diaryContent.count > 0 else {
            alert(message: "내용을 입력하세요")
            return
        }
        
        // 기존 일기 편집 모드
        if let target = editTarget {
            target.title = diaryTitle
            target.photo = diaryPhoto
            target.content = diaryContent
            
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: ComposeViewController.diaryDidChanged, object: nil)
        } else { // 새 일기 쓰기 모드

            DataManager.shared.addNewDiary(diaryPhoto: diaryPhoto, diaryTitle: diaryTitle, diaryContent: diaryContent)
            NotificationCenter.default.post(name: ComposeViewController.newDiaryDidInsert, object: nil)
        }
        
        dismiss(animated: true)
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let diary = editTarget {
            navigationItem.title = "일기 편집"
            titleTextView.text = diary.title
            if let diaryPhoto = diary.photo {
                photoView.image = UIImage(data: diaryPhoto)
            }
            contentTextView.text = diary.content
        } else {
            navigationItem.title = "새 일기"
            titleTextView.placeholder = "일기의 제목을 입력해주세요!"
            contentTextView.placeholder = "누구와 무엇을 먹었나요? :)"
            titleTextView.text = ""
            contentTextView.text = ""
        }
        
    }

}

extension ComposeViewController {
    static let newDiaryDidInsert = Notification.Name(rawValue: "newDiaryDidInsert")
    static let diaryDidChanged = Notification.Name(rawValue: "diaryDidChanged")
}

// MARK: - 사진 업로드
extension ComposeViewController: UIImagePickerControllerDelegate {
    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: false) { () in
                let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                self.photoView.image = img
            }
        }
    
}
