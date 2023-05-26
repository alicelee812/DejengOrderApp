//
//  MenuTableViewController.swift
//  DejengOrderApp
//
//  Created by Alice on 2023/5/11.
//

import UIKit

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var drinkPageControl: UIPageControl!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    
    
    //宣告儲存圖片的drinksPicture
    let drinksPicture = ["tea", "milk tea", "fruit", "milk", "cheese"]
    
    var filteredDrinks = [Record]()
    var allDrinks = [Record]()
    var teaDrinks = [Record]()
    var milkteaDrinks = [Record]()
    var fruitDrinks = [Record]()
    var milkDrinks = [Record]()
    var cheeseDrinks = [Record]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMenu()
        updateUI()
        
        //segmentedControl正常情況下的字是黑色
        typeSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        //segmentedControl被選中的時候字是白色
        typeSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        //固定row的高度
        tableView.rowHeight = 85
        
    }
    
    
    func updateUI() {
        drinkImageView.image = UIImage(named: drinksPicture[index])
        drinkPageControl.currentPage = index
        typeSegmentedControl.selectedSegmentIndex = index
    }
    
    //定義抓資料的fetchMenu
    func fetchMenu() {
        let urlString = "https://api.airtable.com/v0/appK8yMkSmXCX0Hg6/Menu"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.setValue("Bearer patKwiqVg9pn00EPC.e03c8fc0b41480f7ce9b57d84039979edc288edf570304bbee3c89bb00a3f2a9", forHTTPHeaderField: "Authorization")
            //{}的程式是closure，資料下載完成時會執行{}的程式，傳入data(抓到的資料),reponse(後台回傳抓資料的結果),error(錯誤資訊)三個參數。
            URLSession.shared.dataTask(with: request) { data, response , error in
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        //透過decode將Data轉成對應的物件內容
                        let menuResponse = try decoder.decode(MenuResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.allDrinks = menuResponse.records
                            for drink in self.allDrinks {
                                switch drink.fields.classification {
                                case "#Original TEA 原茶系列":
                                    self.teaDrinks.append(drink)
                                case "#Classic MILK TEA 經典奶茶":
                                    self.milkteaDrinks.append(drink)
                                case "#Double FRUIT 雙重水果":
                                    self.fruitDrinks.append(drink)
                                case "#Fresh MILK 鮮奶系列":
                                    self.milkDrinks.append(drink)
                                case "#Cheese MILK FOAM 芝士奶蓋":
                                    self.cheeseDrinks.append(drink)
                                default:
                                    break
                                }
                            }
                            self.filteredDrinks = self.teaDrinks
                            //如果沒有reload data，表格不會更新，只會看到一片空白
                            self.tableView.reloadData()
                        }
                        print("get data")
                    } catch {
                        print(error)
                    }
                } else {
                    print("下載失敗")
                }
            }.resume()
            print("function dataTask執行完會先回傳task，然後呼叫task的resume啟動它")
        }
    }
    
    @IBAction func selectDrinkType(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        updateUI()
        switch index {
        case 0:
            filteredDrinks = teaDrinks
        case 1:
            filteredDrinks = milkteaDrinks
        case 2:
            filteredDrinks = fruitDrinks
        case 3:
            filteredDrinks = milkDrinks
        case 4:
            filteredDrinks = cheeseDrinks
        default:
            break
        }
        tableView.reloadData()
    }
   
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredDrinks.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let drink = filteredDrinks[indexPath.row]
        cell.nameLabel.text = drink.fields.name
        cell.mPrice.text = "$\(drink.fields.medium)"
        cell.lPrice.text = "$"+drink.fields.large

        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
