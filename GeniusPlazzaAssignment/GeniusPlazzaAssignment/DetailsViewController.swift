//
//  DetailsViewController.swift
//  GeniusPlazzaAssignment
//
//  Created by dinesh danda on 5/1/18.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    var urlString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.sharedInstance.showActivityIndicatory()
        webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let myURL = URL(string: urlString) else {
            print("Error: \(urlString) doesn't seem to be a valid URL")
            return
        }
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            webView.loadHTMLString(myHTMLString, baseURL: URL(string: urlString))
            
        } catch let error {
            print("Error: \(error)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView)
    {
        DataManager.sharedInstance.hideActivityIndicator()
        
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        let request = URLRequest(url: URL(string: urlString)!)
        webView.delegate = self
        webView.loadRequest(request)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

