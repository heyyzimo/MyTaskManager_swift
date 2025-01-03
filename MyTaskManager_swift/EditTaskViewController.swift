import UIKit

class EditTaskViewController: UIViewController {

    let editTaskScreen = EditTaskScreenView()
    var task: Task?
    weak var delegate: EditTaskDelegate?

    override func loadView() {
        view = editTaskScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Task"

        if let task = task {
            editTaskScreen.titleTextField.text = task.title
            editTaskScreen.descriptionTextField.text = task.description
            editTaskScreen.statusSwitch.isOn = (task.status == "Completed") // Set switch based on status
            
            if let image = task.image {
                editTaskScreen.photoButton.setImage(image, for: .normal)
            } else {
                editTaskScreen.photoButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped)
        )
    }

    @objc func saveButtonTapped() {
        // Validate the input fields
        guard let title = editTaskScreen.titleTextField.text, !title.isEmpty else {
            showAlert(message: "Please enter a title.")
            return
        }
        guard let description = editTaskScreen.descriptionTextField.text, !description.isEmpty else {
            showAlert(message: "Please enter a description.")
            return
        }

        // Update the task details
        task?.title = title
        task?.description = description
        task?.status = editTaskScreen.statusSwitch.isOn ? "Completed" : "Pending"

        // Notify the delegate
        if let updatedTask = task {
            delegate?.didUpdateTask(updatedTask)
        }

        // Navigate back to the first page (root view controller)
        navigationController?.popToRootViewController(animated: true)
    }


    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
