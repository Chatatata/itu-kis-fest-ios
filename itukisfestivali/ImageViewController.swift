//
//  ImageViewController.swift
//  itukisfestivali
//
//  Created by Efe Helvaci on 27.10.2016.
//  Copyright © 2016 efehelvaci. All rights reserved.
//

import UIKit
import FTIndicator
import Photos

class ImageViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    
    var imageURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Download"), style: .plain, target: self, action: #selector(downloadButtonClicked))
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        image.kf.setImage(with: URL(string: imageURL))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadButtonClicked() {
        FTIndicator.showProgressWithmessage("")
        if image.image != nil {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: self.image.image!)
            }, completionHandler: {success, error in
                FTIndicator.dismissProgress()
                if success {
                    FTIndicator.showSuccess(withMessage: "Image downloaded!")
                } else {
                    FTIndicator.showError(withMessage: "Error downloading image.")
                }
            })
        }
        FTIndicator.dismissProgress()
    }
}
