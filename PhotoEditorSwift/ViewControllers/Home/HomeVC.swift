//
//  HomeVC.swift
//  PhotoEditorSwift
//
//  Created by PhotoEditorSwift on 6/19/21.
//

import UIKit
import Photos
import iOSPhotoEditor

public class HomeVC: UIViewController
{
    @IBOutlet weak var viewShowGallery: UIView!
    @IBOutlet weak var viewCaptureCamera: UIView!

    var imagePicker = UIImagePickerController()
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Editor"
        setupUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupUI()
    {
        setViewRound(view: viewCaptureCamera)
        setViewRound(view: viewShowGallery)
    }
    
    @IBAction func btnCaptureCamera(_ sender: UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnshowGallery(_ sender: UIButton)
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func setViewRound(view: UIView)
    {
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.height/2
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 20
    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imagePicker.dismiss(animated: true, completion: nil)
        let bundle = Bundle(for: type(of:self))
        let storyboard = UIStoryboard(name: "Preview", bundle: bundle)
        let objVC = storyboard.instantiateViewController(withIdentifier: "Preview") as! PreviewVC
        objVC.image = image
        self.navigationController?.pushViewController(objVC, animated: true)
    }
}
