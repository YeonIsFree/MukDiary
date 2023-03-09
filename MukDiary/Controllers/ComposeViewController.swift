//
//  ComposeViewController.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import UIKit
import UITextView_Placeholder
import PhotosUI

class ComposeViewController: UIViewController, UINavigationControllerDelegate {
    var editTarget: Diary?
    
    var imagePicker = UIImagePickerController()
    
    var defualtImg = UIImage(systemName: "photo.on.rectangle.angled")
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let diaryPhoto = photoView.image?.jpegData(compressionQuality: 1.0), photoView.image != defualtImg
            else {
            alert(message: "사진을 선택하세요")
            return
        }
    
        guard let diaryTitle = titleTextView.text, diaryTitle.count > 0 else {
            alert(message: "제목을 입력하세요")
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
    
    func makeDiaryContent() {
        if let diary = editTarget {
            navigationItem.title = "Edit Diary"
            titleTextView.text = diary.title
            if let diaryPhoto = diary.photo {
                photoView.image = UIImage(data: diaryPhoto)
            }
            contentTextView.text = diary.content
        } else {
            navigationItem.title = "New Diary"
            titleTextView.placeholder = "일기의 제목을 입력해주세요!"
            contentTextView.placeholder = "누구와 무엇을 먹었나요? :)"
            photoView.image = defualtImg
            titleTextView.text = ""
            contentTextView.text = ""
        }
    }
    
    func checkAuthStatus() {
        let authStatus = PHPhotoLibrary.authorizationStatus()
        if authStatus == .authorized || authStatus == .limited {
            DispatchQueue.main.async {
                self.openImagePicker()
            }
        } else if authStatus == .denied {
            DispatchQueue.main.async {
                self.authAlert()
            }
            
        } else if authStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                self.checkAuthStatus()
            }
        }
    }
    
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDiaryContent()
    }
}

// MARK: - Image Picker
extension ComposeViewController: UIImagePickerControllerDelegate {
    
    @IBAction func pickButtonTapped(_ sender: UIButton) {
        if photoView.image != defualtImg {
            openImagePicker()
        } else {
            checkAuthStatus()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: false) { () in
                let img = info[.originalImage] as? UIImage
                self.photoView.image = img
            }
        }
    
}

// MARK: - Add, Edit Notification

extension ComposeViewController {
    static let newDiaryDidInsert = Notification.Name(rawValue: "newDiaryDidInsert")
    static let diaryDidChanged = Notification.Name(rawValue: "diaryDidChanged")
}
