//
//  TestListViweController.swift
//  GoodTodoList
//
//  Created by Mehmet Can Şimşek on 8.12.2022.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var listTableView: UITableView!
    let bag = DisposeBag()
    
    private var tasks = BehaviorRelay<[Task]>(value: [Task]())
    var filteredTask: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure() {
        title = "Good List"
        listTableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(goToAddViewController))
    }
    
    @objc func goToAddViewController() {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddTaskViewController") as! AddTaskViewController
        
        vc.taskObservable.subscribe(onNext: { [unowned self] task in
            let priority = Priority(rawValue: vc.prioritySegmentControl.selectedSegmentIndex - 1)
            var existingTask = self.tasks.value
            existingTask.append(task)
            self.tasks.accept(existingTask)
            self.filterTask(priority)
        }).disposed(by: bag)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterTask(_ priorty: Priority?) {
        if priorty == nil {
            self.filteredTask = self.tasks.value
            self.updateUI()
        }else {
            self.tasks.map { tasks in
                return tasks.filter {$0.priority == priorty! }
            }.subscribe(onNext: { [weak self] task in
                self?.filteredTask = task
                self?.updateUI()
            }).disposed(by: bag)
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    
    @IBAction func priortyValueChanged(segmentControl: UISegmentedControl) {
        let priorty = Priority(rawValue: self.segmentControl.selectedSegmentIndex - 1)
        filterTask(priorty)
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.titleLbl.text = self.filteredTask[indexPath.row].title
        return cell
    }
    
    
}
