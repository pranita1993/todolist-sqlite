//
//  NextViewController.swift
//  sqliteday1
//
//  Created by Student P_04 on 09/12/19.
//  Copyright © 2019 Felix ITs. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    
    @IBOutlet weak var textfield1: UITextField!
    
    @IBOutlet weak var textfield2: UITextField!
    
    
    @IBAction func savebutton(_ sender: UIButton) {
        
        let insertQuery = "insert into taskTable(taskId,taskName) values ('\(textfield1.text!)','\(textfield2.text!)')"
        let issuccess = DBWrapper.sharedObj.executeQuery(query: insertQuery)
        if issuccess
        {
            print("insert:success")
        }
        else
        {
            print("insert:failed")
        }
        navigationController?.popViewController(animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
