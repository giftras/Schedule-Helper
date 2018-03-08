//
//  ViewController.swift
//  ScheduleHelper
//
//  Created by Macbook Pro on 9/5/2560 BE.
//  Copyright © 2560 Student. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var CourseID: UITextField!
    @IBOutlet weak var Time: UITextField!
    @IBOutlet weak var SearchCourse: UITextField!
    @IBOutlet weak var ShowCourse: UILabel!
    @IBOutlet weak var ShowTime: UILabel!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func AddCourse(_ sender: Any) {
        if CourseID?.text != "" && Time?.text != ""{
            let newCourse = NSEntityDescription.insertNewObject(forEntityName: "Course", into: context)
            newCourse.setValue(self.CourseID!.text?.uppercased(), forKey: "courseId")
            newCourse.setValue(self.Time!.text?.uppercased(), forKey: "time")
            
            do{
                try context.save()
            }catch{
                print(error)
            }
            
            
        }else{
            print("Please fill course ID and time")
        }
        
    }

    @IBAction func SearchCouseItem(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
        let searchString = self.SearchCourse?.text?.uppercased()
        request.predicate = NSPredicate(format: "courseId == %@", searchString!)
        
        do{
            let result = try context.fetch(request)
            if result.count > 0{
              //let courseid = (result[0] as AnyObject).value(forKey: "courseId") as! String
              let coursetime = (result[0] as AnyObject).value(forKey: "time") as! String
                self.ShowCourse?.text = " Time: " + coursetime
                
            }else{
                self.ShowCourse?.text = "No this course in your schedule"
            }
        }
        catch{
            print(error)
        }

        
        
        
    }

}

