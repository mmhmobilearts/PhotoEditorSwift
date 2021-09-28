

//
//  WallpaperPreviewVC.swift
//  WallUltra
//
//  Created by WallUltra on 23/12/19.
//  Copyright © 2019 WallUltra. All rights reserved.
//

import UIKit
import iOSPhotoEditor

public class PreviewVC: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!

    //MARK: Variables
    var image = UIImage()

    //MARK: Viewcontroller lifecycle
    public override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()

        self.imageView.image = image
    }
}

//MARK: Actions
extension PreviewVC
{
    @IBAction func btnBack_Clicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDownload_Clicked(sender: UIButton)
    {
        let image = self.imageView.image
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Photo Editor", message: "Photo saved successfully to your photo library", preferredStyle: UIAlertController.Style.alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            UIApplication.shared.windows[0].rootViewController!.present(alert, animated: true, completion: nil)
        }        
    }
    
    @IBAction func btnShare_Clicked(sender: UIButton)
    {
        let image = self.imageView.image
        let activityVC = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    @IBAction func btnEdit_Clicked(sender: UIButton)
    {
        let image = self.imageView.image
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        photoEditor.photoEditorDelegate = self
        photoEditor.image = image
        for i in 0...10 {
            photoEditor.stickers.append(UIImage(named: i.description )!)
        }
        photoEditor.modalPresentationStyle = UIModalPresentationStyle.currentContext
        self.present(photoEditor, animated: true, completion: nil)
    }
}

//MARK: Functions
extension PreviewVC: PhotoEditorDelegate
{
    public func doneEditing(image: UIImage) {
        print("DoneEditing")
        self.imageView.image = image
    }
    
    public func canceledEditing() {
        print("CancelledEditing")
    }
    
    func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any]
    {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String
    {
        return input.rawValue
    }
}
