//
//  ViewController.swift
//  TestFoodVisor
//
//  Created by Nizar Elhraiech on 17/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController , UITableViewDelegate  , UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var foodArray = [NSObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllFood()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("FirstListCell", owner: self, options: nil)?.first as!FirstListCell

        let food = self.foodArray[indexPath.row] as? NSDictionary
        
        let nameFood = food!["display_name"] as! String
        let calorie = food!["cal"] as! Int
        let imageFood = food!["imgUrl"] as! String
        let downloadURL = NSURL(string: imageFood)
        
        cell.imgFood.af_setImage(withURL: downloadURL! as URL)
        cell.nameFood.text = nameFood
        cell.calorie.text = "\(calorie) calories"
        
        
        return cell
    }
    
    func getAllFood()  {
        print("hello")
        let getFood = "http://54.72.164.109/itw/food/list/?foo=bar"
        let headers = [
            "Authorization": "Bearer iwn-31@!3pf(w]pmarewj236^in"]
        Alamofire.request(getFood, method: .get,headers: headers).responseJSON { response in
            let result = response.result
            if let dict = result.value  {
                self.foodArray = (dict as! NSArray) as! [NSObject]
                self.tableview.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


