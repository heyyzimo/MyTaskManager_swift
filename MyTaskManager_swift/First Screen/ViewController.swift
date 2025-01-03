import UIKit

class ViewController: UIViewController {
    
    let firstScreen = FirstScreenView()
    var tasks = [Task]()
    //let Numbers = ["Cell", "Work", "Home"]
    
    override func loadView() {
            view = firstScreen
        }
    
    override func viewDidLoad() {
        //view = firstScreen
        
        super.viewDidLoad()
        title = "My Tasks"
        
        firstScreen.tableViewTask.separatorStyle = .none

        
        firstScreen.tableViewTask.delegate = self
        firstScreen.tableViewTask.dataSource = self
        
        //MARK: setting the add button to the navigation controller...
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add, target: self,
        action: #selector(onAddBarButtonTapped)
        )

    }
    
    @objc func onAddBarButtonTapped(){
        let addTaskController = AddTaskViewController()
        addTaskController.delegate = self
        navigationController?.pushViewController(addTaskController, animated: true)
    }
    
    func delegateOnAddTask(task: Task){
            tasks.append(task)
            firstScreen.tableViewTask.reloadData()
        }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TableViewTaskCell
        cell.labelNumber.text = tasks[indexPath.row].status
        
        if let uwTitle = tasks[indexPath.row].title{
            cell.labelTitle.text = "\(uwTitle)"
        }
        if let uwDescription = tasks[indexPath.row].description{
            cell.labelDescription.text = "\(uwDescription)"
        }
        
        if let uwstatus = tasks[indexPath.row].status{
            cell.labelNumber.text = "\(uwstatus))"
        }
        
        if let uwImage = tasks[indexPath.row].image{
                    cell.imageReceipt.image = uwImage
                }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailScreenViewController = DetailsScreenViewController()
        detailScreenViewController.receivedPackage = tasks[indexPath.row]
        
        // Navigating to DisplayViewController
        navigationController?.pushViewController(detailScreenViewController, animated: true)
        }
    
}