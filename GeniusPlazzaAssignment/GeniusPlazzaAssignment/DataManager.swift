//
//  DataManager.swift
//  GeniusPlazzaAssignment
//
//  Created by dinesh danda on 5/1/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit
import EventKit


class DataManager {
    
    var coordinate: CLLocationCoordinate2D?
    
    class var sharedInstance: DataManager {
        struct Static {
            static let instance: DataManager = DataManager()
        }
        return Static.instance
    }
    
    func showActivityIndicatory() {
        
        let window = UIApplication.shared.delegate?.window as! UIWindow
        let container: UIView = UIView()
        container.frame = window.frame
        container.center = window.center
        container.tag = 1009
        container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = window.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        window.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideActivityIndicator() {
        let window = UIApplication.shared.delegate?.window as! UIWindow
        if let containerView = window.viewWithTag(1009)
        {
            containerView.removeFromSuperview()
        }
    }
}
