//
//  AddTaskViewController.swift
//  GoodTodoList
//
//  Created by Mehmet Can Şimşek on 8.12.2022.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var taskTextField: UITextField!
    
    private let taskSubject = PublishSubject<Task>()
    
    var taskObservable: Observable<Task> {
        return taskSubject.asObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        title = "Add Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    @objc func saveTask() {
        guard let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex),
              let title = self.taskTextField.text else { return
        }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        
        self.navigationController?.popViewController(animated: true)
    }
}
