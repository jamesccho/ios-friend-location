//
//  BaseViewController.swift
//  FriendLocationSample
//
//  Created by James Chan on 4/4/2018.
//  Copyright © 2018 James Chan. All rights reserved.
//

import UIKit
import Cache

class BaseViewController: UIViewController {
    
    var ai: UIActivityIndicatorView!
    var storage: Storage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        ai = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        ai.center = self.view.center
        ai.autoresizingMask = [.flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin]
        self.view.addSubview(ai)
        
        let diskConfig = DiskConfig(name: "JsonStorge")
        self.storage = try? Storage(diskConfig: diskConfig)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showIndicator() {
        self.view.bringSubview(toFront: ai)
        ai.startAnimating()
    }
    
    func hideIndicator() {
        ai.stopAnimating()
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
