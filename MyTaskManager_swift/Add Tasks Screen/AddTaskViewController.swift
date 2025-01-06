
import UIKit
import PhotosUI //MARK: importing the library to use PHPicker...


class AddTaskViewController: UIViewController {
    let addTaskScreen = AddTaskView()
    var pickedImage:UIImage?

    override func loadView() {
        view = addTaskScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskScreen.buttonTakePhoto.menu = getMenuImagePicker()
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
            tapRecognizer.cancelsTouchesInView = false
            view.addGestureRecognizer(tapRecognizer)
        
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveBarButtonTapped)
            )
        
        
    }
    
    
    func getMenuImagePicker() -> UIMenu{
            var menuItems = [
                UIAction(title: "Camera",handler: {(_) in
                    self.pickUsingCamera()
                }),
                UIAction(title: "Gallery",handler: {(_) in
                    self.pickPhotoFromGallery()
                })
            ]
            
            return UIMenu(title: "Select source", children: menuItems)
        }
        
    func pickUsingCamera(){
            let cameraController = UIImagePickerController()
            cameraController.sourceType = .camera
            cameraController.allowsEditing = true
            cameraController.delegate = self
            present(cameraController, animated: true)
        }
        
        //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
            var configuration = PHPickerConfiguration()
            configuration.filter = PHPickerFilter.any(of: [.images])
            configuration.selectionLimit = 1
            
            let photoPicker = PHPickerViewController(configuration: configuration)
            
            photoPicker.delegate = self
            present(photoPicker, animated: true, completion: nil)
        }
    
    
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    
    var selectedNumber = "Cell"
    
    
    var delegate:ViewController!
    
    
    @objc func onSaveBarButtonTapped() {
        // Validate title and description
        guard let title = addTaskScreen.textFieldTitle.text, !title.isEmpty else {
            showAlert(message: "Please enter a title. Title can't be empty.")
            return
        }
        guard let description = addTaskScreen.textFieldDescription.text, !description.isEmpty else {
            showAlert(message: "Please enter a valid description.")
            return
        }
        
        // Get status from the UISwitch
        let status = addTaskScreen.statusSwitch.isOn ? "Completed" : "Pending"
        
        // Create new task
        let newTask = Task(
            title: title,
            description: description,
            status: status,
            image: pickedImage ?? UIImage(systemName: "photo")!
        )
        
        // Pass the new task to the delegate
        delegate.delegateOnAddTask(task: newTask)
        navigationController?.popViewController(animated: true)
    }


    
  

       // MARK: - Helper Method to Show Alert
       func showAlert(message: String) {
           let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    

    
    

}


extension AddTaskViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addTaskScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // Do your thing for No image loaded...
        }
    }
}


extension AddTaskViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.addTaskScreen.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}
    
