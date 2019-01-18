//
//  MealWithDifferentCalorieViewController.swift
//  TestFoodVisor
//
//  Created by Nizar Elhraiech on 17/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class MealWithDifferentCalorieViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var foodArray = [NSObject]()
    var starterArray = [Food]()
    var mealPrincipalArray = [Food]()
    var desertArray = [Food]()
    var MealArray = [Meal]()
    var mealWithCaloriePercentArray = [Meal]()
    let bestCalorie = 500
    @IBOutlet weak var typeOfCalorie: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllFood()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealWithCaloriePercentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ThirdListCell", owner: self, options: nil)?.first as!ThirdListCell
        let nameStarter = mealWithCaloriePercentArray[indexPath.row].stater.display_name
        let namemealPrincipal = mealWithCaloriePercentArray[indexPath.row].mealPrincipal.display_name
        let desert = mealWithCaloriePercentArray[indexPath.row].desert.display_name
        let totalCalorie = mealWithCaloriePercentArray[indexPath.row].totalCalorie
        let imgStarter = mealWithCaloriePercentArray[indexPath.row].stater.imgUrl
        let imgmealPrincipal = mealWithCaloriePercentArray[indexPath.row].mealPrincipal.imgUrl
        let imgdesert = mealWithCaloriePercentArray[indexPath.row].desert.imgUrl
        
        
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
                self.getMealWithCaloriePercent()
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

    func getMealWithCaloriePercent(){
        let typeOfCalorieSelected = typeOfCalorie.titleForSegment(at: typeOfCalorie.selectedSegmentIndex)
        let percent : Int
        if typeOfCalorieSelected == "A"{
            percent = 10
        }
        else if typeOfCalorieSelected == "B"{
            percent = 20
        }else if typeOfCalorieSelected == "C"{
            percent = 30
        }else{
            percent = 40
        }
        let PercentOfBestCalorie = (bestCalorie * percent)/100
        let maximumCalorie = PercentOfBestCalorie + bestCalorie
        let minimum = bestCalorie - PercentOfBestCalorie
        mealWithCaloriePercentArray.removeAll()
        for i in 0...self.MealArray.count-1{
            if self.MealArray[i].totalCalorie <= maximumCalorie && self.MealArray[i].totalCalorie >= minimum {
                mealWithCaloriePercentArray.append(self.MealArray[i])
            }
            
        }
        
    }
    
    @IBAction func getTypeOfCalorie(_ sender: Any) {
        getMealWithCaloriePercent()
        self.tableview.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
