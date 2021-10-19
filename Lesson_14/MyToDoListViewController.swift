//
//  MyToDoListViewController.swift
//  Lesson_14
//
//  Created by Александр Бельчиков on 27.05.2021.
//


import UIKit
import Foundation

class TodoListTableCell : UITableViewCell {
    @IBOutlet weak var ToDoTableCellButton: UIButton!
    @IBOutlet weak var ToDoListTableCellLable: UILabel!
}

class MyToDoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ToDoTasksArray: [String] = []
    
    @IBOutlet weak var ToDoListTableView: UITableView!
    @IBOutlet weak var AddToDoTextField: UITextField!
    @IBOutlet weak var SwitchBaseTypeSegmentControlLink: UISegmentedControl!
    @IBAction func SwitchBaseTypeSegmentControl(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(SwitchBaseTypeSegmentControlLink.selectedSegmentIndex, forKey: "SegmentControl")
        //загрузка из базы в var ToDoTasks из realm
        if sender.selectedSegmentIndex == 0{
            ToDoTasksArray = MyBase.shared.GetAllTaskFromRealm()
        }
        if sender.selectedSegmentIndex == 1{
            ToDoTasksArray = MyBase.shared.GetAllTaskFromCore()
        }
        self.ToDoListTableView.reloadData()
    }
    
    //добавление в базы
    @IBAction func AddToDoButton(_ sender: Any) {
        if let text = AddToDoTextField.text, !text.isEmpty{
            if SwitchBaseTypeSegmentControlLink.selectedSegmentIndex == 0{
                MyBase.shared.AddTaskToRealm(AddToDoTextField.text!)
                ToDoTasksArray = MyBase.shared.GetAllTaskFromRealm()
            }
            if SwitchBaseTypeSegmentControlLink.selectedSegmentIndex == 1{
                ToDoTasksArray = MyBase.shared.AddTaskToCore(AddToDoTextField.text!)
            }
            AddToDoTextField.text = ""
            self.ToDoListTableView.reloadData()
        }
    }
    
    //Удаление из базы
    @IBAction func ToDoListCellDeletButt(_ sender: UIButton) {
        
        if SwitchBaseTypeSegmentControlLink.selectedSegmentIndex == 0{
            ToDoTasksArray = MyBase.shared.DeletTaskByIndex(sender.tag)
        }
        if SwitchBaseTypeSegmentControlLink.selectedSegmentIndex == 1{
            ToDoTasksArray = MyBase.shared.DeletTaskByIndexCore(sender.tag)
        }
        
        self.ToDoListTableView.reloadData()
    }

    //начальная загрузка MyToDoListViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToDoListTableView.delegate = self
        ToDoListTableView.dataSource = self
        
        //из настроек взять номер сегмента
        SwitchBaseTypeSegmentControlLink.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SegmentControl")
        
        //загрузка из базы в var ToDoTasks из realm
        if SwitchBaseTypeSegmentControlLink.selectedSegmentIndex == 0{
            ToDoTasksArray = MyBase.shared.GetAllTaskFromRealm()
        }
        //загрузка из базы в var ToDoTasks из core
        if SwitchBaseTypeSegmentControlLink.selectedSegmentIndex == 1{
            ToDoTasksArray = MyBase.shared.GetAllTaskFromCore()
        }
        
    }
    
    
    //прорисовка таблицы от массива ToDoTasksArray
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoTasksArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let TodoTaskCells = tableView.dequeueReusableCell(withIdentifier: "TodoListTableCell", for: indexPath) as! TodoListTableCell
        let TodoTaskCell = ToDoTasksArray[indexPath.row]
        
        TodoTaskCells.ToDoListTableCellLable.text = TodoTaskCell
        TodoTaskCells.ToDoTableCellButton.tag = indexPath.row
        return TodoTaskCells
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}*/
}
