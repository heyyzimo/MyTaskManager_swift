import UIKit

class DetailsScreenViewController: UIViewController {
    let DetailScreen = DetailScreenView()
    
    // Property to hold the received data package from ViewController
    var receivedPackage: Task!

    override func loadView() {
        view = DetailScreen
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
               barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped)
           )
        
        if let image = receivedPackage.image {
                    DetailScreen.imageReceipt.image = image // Assuming DetailScreen has an UIImageView property called imageReceipt
                } else {
                    // Set a default image if none is provided
                    DetailScreen.imageReceipt.image = UIImage(systemName: "person.circle")
                }
        

        if let title = receivedPackage.title, !title.isEmpty {
            DetailScreen.labelTitle.text = "\(title)"
        }

        if let description = receivedPackage.description, !description.isEmpty {
            DetailScreen.labelDescription.text = "Description: \(description)"
        }

        if let status = receivedPackage.status {
            DetailScreen.labelStatus.text = "Status: \(status))"
        }
        
        
        
    }
    
    // MARK: - Edit Button Action
        @objc func editButtonTapped() {
            // Create instance of EditTaskViewController
            let editVC = EditTaskViewController()
            
            // Pass the current task (receivedPackage) to the edit view controller
            editVC.task = receivedPackage
            
            // Set the delegate to self so we can receive updated task info
            editVC.delegate = self
            
            // Push EditTaskViewController onto the navigation stack
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


protocol EditTaskDelegate: AnyObject {
    func didUpdateTask(_ task: Task)
}

extension DetailsScreenViewController: EditTaskDelegate {
    func didUpdateTask(_ task: Task) {
        // Update the current task with the edited details
        receivedPackage = task
        
        // Update the UI with the new details
        DetailScreen.labelTitle.text = task.title
        DetailScreen.labelDescription.text = "Description: \(task.description ?? "")"
        DetailScreen.labelStatus.text = "Status: \(task.status ?? "") "

    }
}
