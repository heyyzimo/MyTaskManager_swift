
import UIKit
import PhotosUI //MARK: importing the library to use PHPicker...


class AddTaskViewController: UIViewController {
    let addTaskScreen = AddTaskView()
    var pickedImage:UIImage?

    // 自定义视图控制器的主视图为 addTaskScreen
    //是uiviewcontroller的子类所以override
    override func loadView() {
        view = addTaskScreen // 将主视图设置为自定义的 addTaskScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置 addTaskScreen 中的 buttonTakePhoto 按钮的菜单为 getMenuImagePicker() 的返回值
        addTaskScreen.buttonTakePhoto.menu = getMenuImagePicker()
        
        // 添加点击手势识别器，用于点击空白处隐藏键盘
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false // 允许触摸事件传递给其他视图
        view.addGestureRecognizer(tapRecognizer) // 将手势识别器添加到主视图
        
        // 在导航栏右侧添加一个保存按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, // 使用系统提供的保存样式按钮
            target: self, // 指定当前视图控制器作为响应目标
            action: #selector(onSaveBarButtonTapped) // 按钮点击时调用 onSaveBarButtonTapped 方法
        )
    }

    
    func getMenuImagePicker() -> UIMenu{
            let menuItems = [
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
            //can edit pic
            cameraController.allowsEditing = true
            //current 控制器
            cameraController.delegate = self
            //show camera
            present(cameraController, animated: true)
        }
        
        //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
            var configuration = PHPickerConfiguration()
            //only pic, no video
            configuration.filter = PHPickerFilter.any(of: [.images])
            //only 1 pic
            configuration.selectionLimit = 1
            //substitue the previous imagepickercontroller
            let photoPicker = PHPickerViewController(configuration: configuration)
        //current 控制器
            photoPicker.delegate = self
        //show gallery picker
            present(photoPicker, animated: true, completion: nil)
        }
    
    
    // 隐藏键盘的方法（需要用 @objc 修饰）
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    
    var selectedNumber = "Cell"
    
    
    var delegate:ViewController!
    
    // 保存按钮点击事件的处理方法（需要用 @objc 修饰）
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

//deal with camera pic
extension AddTaskViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)//close camera
        //info: 包含用户选择的图片信息。这里使用 .editedImage 获取用户编辑后的图片。
        if let image = info[.editedImage] as? UIImage{
            self.addTaskScreen.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            // no pic
        }
    }
}

//deal with gallery pic
extension AddTaskViewController:PHPickerViewControllerDelegate{
    //results: 包含用户选择的图片结果（PHPickerResult 对象）。
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        //提供选择的资源信息，可以异步加载图片或其他类型的数据。
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            //检查资源是否可以加载为指定类型（这里是 UIImage）
            if item.canLoadObject(ofClass: UIImage.self){
                                                        //异步加载图片并处理。
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    //确保更新 UI 的代码在主线程中执行。
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage {
                            // 如果成功将加载的对象转换为 UIImage 类型
                            // 设置按钮的图片为用户选择的图片，使用原始渲染模式（不受按钮样式影响）
                            self.addTaskScreen.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            // 将选中的图片保存到 pickedImage 属性中，供后续使用
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
}
    
