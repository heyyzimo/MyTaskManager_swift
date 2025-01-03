import UIKit

class EditTaskViewController: UIViewController {

    // Use the custom view to manage the UI
    let editTaskScreen = EditTaskScreenView()
    
    var task: Task?
    weak var delegate: EditTaskDelegate?

    override func loadView() {
        // Set the custom view as the main view of the controller
        view = editTaskScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the title
        title = "Edit Task"
        
        // Populate the UI with the task details if available
        if let task = task {
            editTaskScreen.titleTextField.text = task.title
            editTaskScreen.descriptionTextField.text = task.description
            editTaskScreen.statusTextField.text = task.status
           
            if let image = task.image {
                    editTaskScreen.photoButton.setImage(image, for: .normal)
                } else {
                    // Set a default image if none is provided
                    editTaskScreen.photoButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
                }
        }
        
        
        
        // Add a Save button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped)
        )
    }

    @objc func saveButtonTapped() {
        // Validate and save the updated task details
        guard let title = editTaskScreen.titleTextField.text, !title.isEmpty else {
            showAlert(message: "Please enter a title.")
            return
        }
        guard let description = editTaskScreen.descriptionTextField.text, !description.isEmpty else {
            showAlert(message: "Please enter a description.")
            return
        }
        

        task?.title = title
        task?.description = description
        task?.status = editTaskScreen.statusTextField.text ?? ""
       
        
        // Notify the delegate about the updated task
        if let updatedTask = task {
            delegate?.didUpdateTask(updatedTask)
        }
        
        // Pop the view controller
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

   
}
