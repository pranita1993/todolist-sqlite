//
//  WrapperClass.swift
//  sqliteday1
//
//  Created by Student P_04 on 11/12/19.
//  Copyright © 2019 Felix ITs. All rights reserved.
//

import Foundation

class DBWrapper
{
    static let sharedObj = DBWrapper()
    var taskNameArray : [String]!
    var taskIDArray : [String]!
    
 func getDatabasepath()->String
  {
    let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let dbpath = dir.first!
    return dbpath + "myDatabase.sqlite"
  }
    func executeQuery(query:String)->Bool
    {
        var db:OpaquePointer?=nil
        var stmt:OpaquePointer?=nil
        var success = false
        
        let databasepath = getDatabasepath()
        if sqlite3_open(databasepath, &db) == SQLITE_OK
        {
           if sqlite3_prepare_v2(db!, query, -1, &stmt, nil) == SQLITE_OK
           {
            if sqlite3_step(stmt!) == SQLITE_DONE
            {
                success = true
                sqlite3_finalize(stmt!)
                sqlite3_close(db!)
            }
            else
            {
                print("Error in step-execution\(sqlite3_errmsg(db!))")
            }
            }
            else
           {
            print("Error in prepare v2\(sqlite3_errmsg(db!))")
            }
        }
        else
        {
            print("Error in open \(sqlite3_errmsg(db!))")
        }
       return success
    }
    
    
    
    func getAllTask(query:String)
    {
        taskIDArray = [String]()
        taskNameArray = [String]()
        
        var db:OpaquePointer?=nil
        var stmt:OpaquePointer?=nil
      
        
        let databasepath = getDatabasepath()
        
        if sqlite3_open(databasepath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db!, query, -1, &stmt, nil) == SQLITE_OK
            {
                taskIDArray.removeAll()
                taskNameArray.removeAll()
                while sqlite3_step(stmt!) == SQLITE_ROW
                {
                    let tId = sqlite3_column_text(stmt!, 0)
                    let taskId = String(cString: tId!)
                    
                    taskIDArray.append(taskId)
                    let tName = sqlite3_column_text(stmt!, 1)
                    let taskName = String(cString: tName!)
                    taskNameArray.append(taskName)
                    }
                print("Ids =\(taskIDArray)")
                print("Name=\(taskNameArray)")
            }
            else
            {
                print("Error in prepare v2\(sqlite3_errmsg(db!))")
            }
        }
        else
        {
            print("Error in open \(sqlite3_errmsg(db!))")
        }
        
    }

    
    
    func createTable()
    {
        let createQuery = "create table if not exists taskTable(taskId text,taskName text)"
        let isSuccess = executeQuery(query: createQuery)
        if isSuccess
        {
            print("table creation:Success")
        }
        else{
            print("table creation:Failed")
        }
    }
    
    
    
    
}
