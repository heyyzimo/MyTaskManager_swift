import UIKit

class ViewController: UIViewController {

    // UI Components and Data
    let firstScreen = FirstScreenView()
    //初始化一个空的 Task 数组，表示目前还没有任务。
    var tasks = [Task]()
    //same thing but a filtered one
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
        //.none 是 UITableViewCell.SeparatorStyle的，不显示分隔线。
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
// 扩展 ViewController，遵循 UITableViewDelegate 和 UITableViewDataSource 协议，处理表格视图的数据源和用户交互逻辑
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    // 返回指定 section 中的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 根据是否处于搜索模式，返回 filteredTasks 或 tasks 的数量
        return isSearching ? filteredTasks.count : tasks.count
    }
    
    // 配置和返回指定位置的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 重用标识符 "tasks" 获取或创建一个 TableViewTaskCell 类型的单元格
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasks", for: indexPath) as! TableViewTaskCell
        
        // 根据是否处于搜索模式，选择 filteredTasks 或 tasks 中对应的任务
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        
        // 设置单元格中任务的标题、描述和状态标签
        cell.labelTitle.text = task.title
        cell.labelDescription.text = task.description
        cell.labelStatus.text = task.status
        
        // 如果任务包含图像，将其显示在单元格中
        if let image = task.image {
            cell.imageReceipt.image = image
        }

        return cell
    }
    
    // 处理用户点击单元格的交互事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 创建任务详情视图控制器
        let detailScreenViewController = DetailsScreenViewController()
        
        // 根据是否处于搜索模式，选择对应的任务
        let task = isSearching ? filteredTasks[indexPath.row] : tasks[indexPath.row]
        
        // 将选中的任务传递给详情视图控制器
        detailScreenViewController.receivedPackage = task
        
        // 设置详情视图控制器的委托，用于任务的删除和编辑回调
        detailScreenViewController.deletionDelegate = self
        detailScreenViewController.editDelegate = self
        
        // 将详情视图控制器推送到导航堆栈中
        navigationController?.pushViewController(detailScreenViewController, animated: true)
    }
}



// MARK: - TaskDeletionDelegate
// 扩展 ViewController，遵循 TaskDeletionDelegate 协议，用于处理任务删除事件的回调
extension ViewController: TaskDeletionDelegate {

    // 删除任务时的回调方法
    func didDeleteTask(_ taskID: UUID) {
        // 找到任务在 tasks 数组中的索引
        if let index = tasks.firstIndex(where: { $0.id == taskID }) {
            // 从 tasks 数组中移除该任务
            tasks.remove(at: index)
            
            // 如果处于搜索模式，同步移除 filteredTasks 中的任务
            if isSearching {
                filteredTasks.removeAll { $0.id == taskID }
            }
            
            // 刷新表格视图，更新界面
            firstScreen.tableViewTask.reloadData()
        }
    }
}

// 将 ViewController 扩展为符合 EditTaskDelegate 协议
extension ViewController: EditTaskDelegate {
    
    // 当任务被更新时的回调方法
    //  _  调用时可以省略参数名updatedTask:
    func didUpdateTask(_ updatedTask: Task) {
        // 查找已更新任务在 tasks 数组中的索引
        //$0 引用当前传入的元素。
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            // 更新 tasks 数组中的任务
            tasks[index] = updatedTask
            
            // 如果当前在搜索模式下，需要同时更新 filteredTasks 数组
            if isSearching {
                // 查找已更新任务在 filteredTasks 数组中的索引
                if let filteredIndex = filteredTasks.firstIndex(where: { $0.id == updatedTask.id }) {
                    // 更新 filteredTasks 数组中的任务
                    filteredTasks[filteredIndex] = updatedTask
                }
            }
            
            // 刷新主界面的任务列表以反映更新后的数据
            firstScreen.tableViewTask.reloadData()
        }
    }
}


// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    // 当搜索框中的文本发生变化时触发
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // 如果搜索框为空，则停止搜索，清空过滤任务列表
            isSearching = false
            filteredTasks.removeAll()
        } else {
            // 如果有输入内容，启用搜索模式，过滤任务列表
            isSearching = true
            filteredTasks = tasks.filter { task in
                // 检查任务标题是否包含搜索文本（忽略大小写）
                task.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        // 刷新任务表视图以显示过滤结果
        firstScreen.tableViewTask.reloadData()
    }
    
    // 当用户点击搜索框的取消按钮时触发
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // 停止搜索模式，清空搜索框内容和过滤任务列表
        isSearching = false
        searchBar.text = ""
        filteredTasks.removeAll()
        // 刷新任务表视图以恢复到初始任务列表
        firstScreen.tableViewTask.reloadData()
    }
}
