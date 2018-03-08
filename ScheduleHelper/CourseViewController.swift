//
//  CourseViewController.swift
//  ScheduleHelper
//
//  Created by Macbook Pro on 9/6/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import UIKit
import CoreData

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    var courseArray:[Course] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        self.fetchData()
        self.TableView.reloadData()

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let courseinfo = courseArray[indexPath.row]
        cell.textLabel!.text = courseinfo.courseId! + " Time: " + courseinfo.time!
        return cell
    }    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let course = courseArray[indexPath.row]
            context.delete(course)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                courseArray = try context.fetch(Course.fetchRequest())
            }catch{
                print(error)
            }

        }
        tableView.reloadData()
    }
    
    func fetchData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            courseArray = try context.fetch(Course.fetchRequest())
        }catch{
            print(error)
        }

        
    }

    
}
