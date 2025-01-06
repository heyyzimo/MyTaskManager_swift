import UIKit



class DetailsScreenViewController: UIViewController {
    let DetailScreen = DetailScreenView()
    
    // Property to hold the received task from ViewController
    var receivedPackage: Task!
    
    // Delegate to notify deletion
    weak var deletionDelegate: TaskDeletionDelegate?
    weak var editDelegate: EditTaskDelegate?


    override func loadView() {
        view = DetailScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Edit Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped)
        )
        
        // Add Delete Button Action
        DetailScreen.buttonDelete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        // Populate the UI with the task details
        if let image = receivedPackage.image {
            DetailScreen.imageReceipt.image = image
        } else {
            DetailScreen.imageReceipt.image = UIImage(systemName: "person.circle")
        }
        
        if let title = receivedPackage.title, !title.isEmpty {
            DetailScreen.labelTitle.text = "\(title)"
        }
        
        if let description = receivedPackage.description, !description.isEmpty {
            DetailScreen.labelDescription.text = "Description: \(description)"
        }
        
        if let status = receivedPackage.status {
            DetailScreen.labelStatus.text = "Status: \(status)"
        }
    }
    
    @objc func editButtonTapped() {
            let editVC = EditTaskViewController()
            editVC.task = receivedPackage
            editVC.delegate = editDelegate // Pass the delegate
            navigationController?.pushViewController(editVC, animated: true)
        }
    
    // MARK: - Delete Button Action
    @objc func deleteButtonTapped() {
        // Confirm Deletion
        let alert = UIAlertController(
            title: "Delete Task",
            message: "Are you sure you want to delete this task?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deletionDelegate?.didDeleteTask(self.receivedPackage.id)
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}

// MARK: - EditTaskDelegate
extension DetailsScreenViewController: EditTaskDelegate {
    func didUpdateTask(_ task: Task) {
        // Update the current task
        receivedPackage = task
        
        // Refresh the UI with the updated task details
        DetailScreen.labelTitle.text = task.title
        DetailScreen.labelDescription.text = "Description: \(task.description ?? "")"
        DetailScreen.labelStatus.text = "Status: \(task.status ?? "")"
    }
}


