//
//  ViewController.swift
//  GeniusPlazzaAssignment
//
//  Created by dinesh danda on 5/1/2018.
//  Copyright © 2018 dinesh danda. All rights reserved.
//

import UIKit
enum mediaType:Int {
    case applemusic = 0
    case itunes
    case iOS
    case mac
    case audio
    case books
    case tv
    case movies
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                self.image = image
            }
        }).resume()
    }}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var mediaButton: UIBarButtonItem!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var pickerBackView: UIView!
    @IBOutlet weak var mediaTypePicker: UIPickerView!
    @IBOutlet weak var pickerViewBottomConstraint: NSLayoutConstraint!
    
    var selectedIndex = 0
    var tempSelctedIndex = 0
    
    let mediaTypeArray = ["Apple Music","itunes Music","iOS Apps","Mac Apps","Audio Books","Books","TV Shows","Movies"]
    
    var results = [Dictionary<String, Any>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewBottomConstraint.constant = -(pickerBackView.frame.size.height)
        let selectedRowTitle = mediaTypeArray[0]
        selectedIndex = 0
        mediaButton.title = selectedRowTitle
        getDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUrlforMediaType() -> String {
        
        switch selectedIndex {
        case mediaType.applemusic.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/10/explicit.json"
        case mediaType.itunes.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json"
        case mediaType.iOS.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json"
        case mediaType.mac.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/macos-apps/top-free-mac-apps/all/10/explicit.json"
        case mediaType.audio.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/audiobooks/top-audiobooks/all/10/explicit.json"
        case mediaType.books.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/books/top-free/all/10/explicit.json"
        case mediaType.tv.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/tv-shows/top-tv-episodes/all/10/explicit.json"
        case mediaType.movies.rawValue:
            return "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
        default:
            return "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks/all/10/explicit.json"
        }
    }
    
    func getDetails() {
        
        let url = getUrlforMediaType()
        DataManager.sharedInstance.showActivityIndicatory()
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            DispatchQueue.main.async {
                DataManager.sharedInstance.hideActivityIndicator()
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                if let jsonResult = json["feed"]!["results"] {
                    DispatchQueue.main.async {
                        self.results = jsonResult as! [Dictionary<String, Any>]
                        self.resultsTableView.reloadData()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.resultsTableView.reloadData()
                        }
                    }
                }
            } catch {
                print("error")
            }
            }.resume()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableviewCell", for: indexPath as IndexPath) as! CustomTableviewCell
        let dictionary = results[indexPath.row]
        cell.titleLabel.text = dictionary["name"] as? String
        cell.artistNameLabel.text = dictionary["artistName"] as? String
        cell.imageView?.backgroundColor = UIColor.red
        cell.imageView?.imageFromServerURL(urlString: dictionary["artworkUrl100"] as! String)
        cell.dateLabel.text = dictionary["releaseDate"] as? String
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictionary = results[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        controller.urlString = (dictionary["url"] as? String)!
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return mediaTypeArray.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return mediaTypeArray[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        tempSelctedIndex = row
    }
    
    
    func showMediaPicker()
    {
        UIView.animate(withDuration: 1.0) {
            self.pickerViewBottomConstraint.constant = 0
        }
        
    }
    
    func hideMediaPicker()
    {
        UIView.animate(withDuration: 1.0) {
            self.pickerViewBottomConstraint.constant = -(self.pickerBackView.frame.size.height)
            
        }
        
    }
    
    @IBAction func doneMediaType(_ sender: Any) {
        
        selectedIndex = tempSelctedIndex
        let selectedRowTitle = mediaTypeArray[selectedIndex]
        mediaButton.title = selectedRowTitle
        getDetails()
        self.hideMediaPicker()
    }
    @IBAction func mediaButtonAction(_ sender: Any) {
        
        tempSelctedIndex = selectedIndex
        showMediaPicker()
        
    }
    @IBAction func reminderPickerCloseTapped(_ sender: Any) {
        
        self.hideMediaPicker()
        
    }
}

