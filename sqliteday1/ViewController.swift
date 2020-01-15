//
//  ViewController.swift
//  sqliteday1
//
//  Created by Student P_04 on 09/12/19.
//  Copyright © 2019 Felix ITs. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
var tIDArray = [String]()
    var tNameArray = [String]()
    override func viewWillAppear(_ animated: Bool) {
        let selectQuery = "select * from taskTable"
        DBWrapper.sharedObj.getAllTask(query: selectQuery)
        tIDArray = DBWrapper.sharedObj.taskIDArray
        tNameArray = DBWrapper.sharedObj.taskNameArray
        tableview.reloadData()
        print(tIDArray)
        print(tNameArray)
        

        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableview.cellForRow(at: indexPath)
       //let id = cell?.textLabel?.text
       // let name = cell?.detailTextLabel?.text
        let edit = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        edit.taskname = (cell?.detailTextLabel?.text)!
        edit.taskid = (cell?.textLabel?.text)!
        navigationController?.pushViewController(edit, animated: true)
        
    }
    
    
    @IBAction func nextbutton(_ sender: UIBarButtonItem) {
        let next = storyboard?.instantiateViewController(withIdentifier: "NextViewController") as!NextViewController
        navigationController?.pushViewController(next, animated: true)
    }
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tIDArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = tIDArray[indexPath.row]
        cell.detailTextLabel?.text = tNameArray[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

