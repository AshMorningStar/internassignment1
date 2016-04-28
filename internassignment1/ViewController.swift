//
//  ViewController.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 27/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var tableView:UITableView!
    
    var namesStorage: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let parkingLotInfoURL = "http://api.mapsynq.com/api/1.0/feeds/pds.json"
        let nsUrlForParkingLot = NSURL(string: parkingLotInfoURL)!
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(nsUrlForParkingLot) { (data :NSData?, response: NSURLResponse?, error: NSError?) in
            
            if let reponseData = data{
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(reponseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dictJson = json as? Dictionary<String,AnyObject>{
                        
                        if let data = dictJson["data"] as? [Dictionary<String,AnyObject>] {
                            
                            
                            for names in data {
                                let name = names["name"] as! String
                                
                                
                                print(name)
                                
                                self.namesStorage.append(name)
                                
                                
                                
                                
                            }
                            
                            print(self.namesStorage[1])
                            self.tableView.reloadData()
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    //print(json)
                    
                    
                }catch{
                    
                    print("Serialization Failed")
                }
                
                
                
                
                
                
                
                
                
            }
            }.resume()
        

                
                  
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesStorage.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        
        
        if let label = cell.textLabel{
            label.text = namesStorage[indexPath.row]
        }
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedParkingName = namesStorage[indexPath.row]
          print("User has selected \(selectedParkingName)")

    }


}

