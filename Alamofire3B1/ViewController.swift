//
//  ViewController.swift
//  Alamofire3B1
//
//  Created by Jakkawad Chaiplee on 4/26/2559 BE.
//  Copyright © 2559 Jakkawad Chaiplee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView:UITableView!
    
    var mainDataArray = NSArray()
    var products = [Product]()
    var filterProduct = [Product]()
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(products.count)
        return products.count
        //print(mainDataArray.count)
        //return mainDataArray.count
        //return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell0 = tableView.dequeueReusableCellWithIdentifier("tableCell0")
        //cell0?.textLabel?.text = "Err"
        let product = products[indexPath.row]
        cell0?.textLabel?.text = product.name
        return cell0!
    }
    func loadData() {
        Alamofire.request(.POST, "https://www.all2sale.com/sendmail/testfunction/json/apitest.php", parameters: ["api":"productall_id","productall_id":"2"])
            .responseJSON { response in
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                //self.mainDataArray = response.result.value as! NSArray
                //print(self.mainDataArray.description)
                let value = response.result.value
                self.mainDataArray = response.result.value as! NSArray
                //self.tableView.reloadData()
                let json = JSON(value!)
                //let productName = json[0]
                //print(productName)
                //print("JSON: \(json)")
                //print(json["productName"].stringValue)
                //var product = [Product]()
                for (index, object) in json {
                    let name = object["productName"].stringValue
                    let id = object["Id"].stringValue
                    //print("Name \(name) : id \(id)")
                    self.products.append(Product(_name: name, _id: id))
                    //print(product.count)
                    self.tableView.reloadData()
                }
                
                //print(pro)
                
            }
        //print(products.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(products.count)
        loadData()
        
        /*
        products = [
            Product(_name:"D", _id: "d")
        ]
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

