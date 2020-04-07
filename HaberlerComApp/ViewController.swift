//
//  ViewController.swift
//  HaberlerComApp
//
//  Created by Mehmet Baran on 4.04.2020.
//  Copyright © 2020 Mehmet Baran. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    //MARK: - Variables
    var allFeaturedNews = [NewsModal]();
    
    //MARK: - IBOutlets
    @IBOutlet weak var table: UITableView!

     //MARK: - Statements

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.tableFooterView  = UIView();
        getFeaturedNews(); //Manşette olan haberleri getir.
    }
    
    //MARK: TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFeaturedNews.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "FeaturedCell", for: indexPath) as! FeaturedTableViewCell;
        
        if  allFeaturedNews.count > 0 {
            
            cell.newsImage.sd_setImage(with: URL(string:allFeaturedNews[indexPath.row].imageUrl.replacingOccurrences(of: "http", with: "https")));
        cell.newsTitle.text = allFeaturedNews[indexPath.row].title;
            
       }
        
        return cell;
        
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openReadNews(news: allFeaturedNews[indexPath.row]);
    }

     //MARK: - Functions
    func openReadNews(news: NewsModal){
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
         let vc : ReadNewsDetailViewController = storyboard.instantiateViewController(identifier: "ReadNewsDetailStoryboardID") as! ReadNewsDetailViewController;
         vc.selectedNews = news;
         self.show(vc, sender: nil);
    }
    
    func getFeaturedNews(){
        
        MBProgressHUD.showAdded(to: self.view, animated: true);
        
        AF.request("https://app.haberler.com/services/haberlercom/2.11/service.asmx/haberler?category=manset&count=35&offset=0&deviceType=1&userId=61ed99e0c09a8664").responseJSON { response in
            
            if let json = response.value {
                
                let jsonDict = json as! NSDictionary;
                let array = jsonDict["news"] as! NSArray;
                
                for object in array {
                    let objectAsArray = object as! NSDictionary;
                    let newObjectNews = self.createNewsFromObject(json: objectAsArray);
                    self.allFeaturedNews.append(newObjectNews);
                    
                    }
               
                self.table.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true);
            }
        }
    }
    
    func createNewsFromObject(json: NSDictionary) -> NewsModal {

        let news = NewsModal(title: json["title"] as! String,
                             imageUrl: json["imageUrl"] as! String,
                             spot: json["spot"] as! String,
                             videoUrl: json["videoUrl"] as! String);
        
        return news;
   }
    
}

