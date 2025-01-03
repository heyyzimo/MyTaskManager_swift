import UIKit

class ViewController: UIViewController {

    // TaskDeletionDelegate Protocol
    protocol TaskDeletionDelegate: AnyObject {
        func didDeleteTask(_ taskID: UUID)
    }
    
    // UI Components and Data
    let firstScreen = FirstScreenView()
    var tasks = [Task]()
    var filteredTasks = [Task]() // Holds the filtered tasks
    var isSearching = false // Tracks whether search is active
    let searchBar = UISearchBar() // Search bar

    override func loadView() {
        view = firstScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Tasks"
        
        // TableView Setup
        firstScreen.tableViewTask.separatorStyle = .none
        firstScreen.tableViewTask.delegate = self
        firstScreen.tableViewTask.dataSource = self
        
        // Search Bar Setup
        searchBar.delegate = self
        searchBar.placeholder = "Search Tasks"
        searchBar.showsCancelButton = true // Enable cancel button
        navigationItem.titleView = searchBar
        
        // Add Task Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(onAddBarButtonTapped)
        )
    }
    
    // Add Task
    @objc func onAddBarButtonTapped() {
        let addTaskController = AddTaskViewController()
        addTaskController.delegate = self
        navigationController?.pushViewController(addTaskController, animated: true)
    }
    
    // Delegate Method for Adding Task
    func delegateOnAddTask(task: Task) {
        tasks.append(task)
        firstScreen.tableViewTask.reloadData()
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredTasks.count : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TableViewTaskCell
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        
        cell.labelTitle.text = task.title
        cell.labelDescription.text = task.description
        cell.labelStatus.text = task.status
        
        if let image = task.image {
            cell.imageReceipt.image = image
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailScreenViewController = DetailsScreenViewController()
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        detailScreenViewController.receivedPackage = task
        detailScreenViewController.deletionDelegate = self
        detailScreenViewController.editDelegate = self
        navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
}

// MARK: - TaskDeletionDelegate
extension ViewController: TaskDeletionDelegate {
    func didDeleteTask(_ taskID: UUID) {
        if let index = tasks.firstIndex(where: { $0.id == taskID }) {
            tasks.remove(at: index)
            if isSearching {
                filteredTasks.removeAll { $0.id == taskID }
            }
            firstScreen.tableViewTask.reloadData()
        }
    }
}

// MARK: - EditTaskDelegate
extension ViewController: EditTaskDelegate {
    func didUpdateTask(_ updatedTask: Task) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
            if isSearching {
                if let filteredIndex = filteredTasks.firstIndex(where: { $0.id == updatedTask.id }) {
                    filteredTasks[filteredIndex] = updatedTask
                }
            }
            firstScreen.tableViewTask.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredTasks.removeAll()
        } else {
            isSearching = true
            filteredTasks = tasks.filter { task in
                task.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        firstScreen.tableViewTask.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        filteredTasks.removeAll()
        firstScreen.tableViewTask.reloadData()
    }
}
