//
//  MealWithGoodCalorieViewController.swift
//  FoodvisorTest
//
//  Created by Nizar Elhraiech on 17/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class MealWithGoodCalorieViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var foodArray = [NSObject]()

    var starterArray = [Food]()
    var mealPrincipalArray = [Food]()
    var desertArray = [Food]()
    var MealArray = [Meal]()
    var bestMealWithCalorieTenPercentArray = [Meal]()
    let bestCalorie = 500
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllFood()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bestMealWithCalorieTenPercentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SecondListCell", owner: self, options: nil)?.first as!SecondListCell
        let nameStarter = bestMealWithCalorieTenPercentArray[indexPath.row].stater.display_name
        let namemealPrincipal = bestMealWithCalorieTenPercentArray[indexPath.row].mealPrincipal.display_name
        let desert = bestMealWithCalorieTenPercentArray[indexPath.row].desert.display_name
        let totalCalorie = bestMealWithCalorieTenPercentArray[indexPath.row].totalCalorie
        let imgStarter = bestMealWithCalorieTenPercentArray[indexPath.row].stater.imgUrl
        let imgmealPrincipal = bestMealWithCalorieTenPercentArray[indexPath.row].mealPrincipal.imgUrl
        let imgdesert = bestMealWithCalorieTenPercentArray[indexPath.row].desert.imgUrl
        
        
        let downloadURLImgStarter = NSURL(string: imgStarter!)
        let downloadURLImgMealPrincipal = NSURL(string: imgmealPrincipal!)
        let downloadURLImgDesert = NSURL(string: imgdesert!)
        
        cell.starter.af_setImage(withURL: downloadURLImgStarter! as URL)
        cell.mainCourse.af_setImage(withURL: downloadURLImgMealPrincipal! as URL)
        cell.desert.af_setImage(withURL: downloadURLImgDesert! as URL)
        cell.nameStarter.text = nameStarter
        cell.nameMeal.text = namemealPrincipal
        cell.nameDesert.text = desert
        cell.totalCalorie.text = "\(totalCalorie) calories"
        
        
        return cell
    }

    func getAllFood()  {
        let getFood = "http://54.72.164.109/itw/food/list/?foo=bar"
        let headers = [
            "Authorization": "Bearer iwn-31@!3pf(w]pmarewj236^in"]
        Alamofire.request(getFood, method: .get,headers: headers).responseJSON { response in
            let result = response.result
            if let dict = result.value  {
                self.foodArray = (dict as! NSArray) as! [NSObject]
                self.tableview.reloadData()
                for i in 0...self.foodArray.count-1{
                    let JsonResult = self.foodArray[i] as? NSDictionary
                    let display_name = JsonResult!["display_name"]! as! String
                    let calorie = JsonResult!["cal"]! as! Int
                    let type = JsonResult!["type"]! as! String
                    let imgUrl = JsonResult!["imgUrl"]! as! String
                    let food:Food = Food(display_name: display_name, cal: calorie, type: type, imgUrl: imgUrl)
                    if type == "starter" {
                        self.starterArray.append(food)
                    }
                    else if type == "dish" {
                        self.mealPrincipalArray.append(food)
                    }
                    else{
                        self.desertArray.append(food)
                    }
                }
                self.combinAllFood()
                self.getbestMealWithCalorieTenPercent()
                self.tableview.reloadData()
            }
        }
    }
    
    func combinAllFood(){
        for i in 0...self.mealPrincipalArray.count-1{
            for j in 0...self.starterArray.count-1{
                for k in 0...self.desertArray.count-1{
                    print(self.starterArray[j].cal!)
                    print(self.mealPrincipalArray[i].cal!)
                    print(self.desertArray[k].cal!)

                    let totalCalorie = self.starterArray[j].cal! + self.mealPrincipalArray[i].cal! + self.desertArray[k].cal!
                    let meal:Meal = Meal(stater: self.starterArray[j], mealPrincipal: self.mealPrincipalArray[i], desert: self.desertArray[k], totalCalorie: totalCalorie)
                    self.MealArray.append(meal)
                }
            }
        }
        
    }
    
    func getbestMealWithCalorieTenPercent(){
        let TenPercentOfBestCalorie = (bestCalorie * 10)/100
        let maximumCalorie = TenPercentOfBestCalorie + bestCalorie
        let minimum = bestCalorie - TenPercentOfBestCalorie
        for i in 0...self.MealArray.count-1{
            if self.MealArray[i].totalCalorie <= maximumCalorie && self.MealArray[i].totalCalorie >= minimum {
                bestMealWithCalorieTenPercentArray.append(self.MealArray[i])
            }
            
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
