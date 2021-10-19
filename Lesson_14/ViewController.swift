//
//  ViewController.swift
//  Lesson_14
//
//  Created by Александр Бельчиков on 27.05.2021.
//

import UIKit
import Foundation
import RealmSwift
//import Realm
import CoreData

//первый экран
class ViewController: UIViewController {
    @IBOutlet weak var AddNameText1: UITextField!
    @IBOutlet weak var AddNameText2: UITextField!
    @IBAction func AddNameButt(_ sender: Any) {
        MyBase.shared.userName = AddNameText1.text ?? ""
        MyBase.shared.userName2 = AddNameText2.text ?? ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AddNameText1.text = MyBase.shared.userName
        AddNameText2.text = MyBase.shared.userName2
    }
}



//модель для core
//@objc public class ToDoTasksCore: NSManagedObject {
//    @NSManaged public var task: String?
//}
