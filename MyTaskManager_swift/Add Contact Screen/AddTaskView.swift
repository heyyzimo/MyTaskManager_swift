//
//  AddTaskView.swift
//  hw4
//
//  Created by Zimo Liu on 10/3/24.
//

import UIKit

class AddTaskView: UIView {
    
    var labelAddANewTask: UILabel!
    var labelPhoto: UILabel!

    var buttonTakePhoto: UIButton!
    var selectStatusTypeButton: UIButton!
    var buttonAdd: UIButton!

    
    var textFieldTitle: UITextField!
    var textFieldDescription: UITextField!
    var textFieldStatus: UITextField!


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setting the background color
        self.backgroundColor = .white
        
        // Initializing the UI elements
        setupLabelAddANewTask()
        setupLabelPhoto()

        setupTextFieldTitle()
        setupTextFieldDescription()
        setupTextFieldStatus()
       
        
        setupbuttonTakePhoto()
        setupselectStatusTypeButton()
        setupbuttonAdd()
        
        // Initializing constraints
        initConstraints()
    }
    
    // MARK: Initializing constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Create Profile Label
            labelAddANewTask.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelAddANewTask.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            // Title TextField
            textFieldTitle.topAnchor.constraint(equalTo: labelAddANewTask.bottomAnchor, constant: 24),
            textFieldTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Description TextField
            textFieldDescription.topAnchor.constraint(equalTo: labelPhoto.bottomAnchor, constant: 16),
            textFieldDescription.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldDescription.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            buttonTakePhoto.topAnchor.constraint(equalTo: textFieldTitle.bottomAnchor, constant: 16),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 100),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 100),
            
            labelPhoto.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 0),
            labelPhoto.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

                   
             
            textFieldStatus.topAnchor.constraint(equalTo: textFieldDescription.bottomAnchor, constant: 11),
            textFieldStatus.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldStatus.widthAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.widthAnchor),

        
        ])
    }
    
    func setupselectStatusTypeButton(){
        selectStatusTypeButton = UIButton(type: .system)
        selectStatusTypeButton.setTitle("Home", for: .normal)
        selectStatusTypeButton.showsMenuAsPrimaryAction = true
        selectStatusTypeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectStatusTypeButton)
        
    }
    
        func setupbuttonTakePhoto(){
            buttonTakePhoto = UIButton(type: .system)
            buttonTakePhoto.setTitle("", for: .normal)
            buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            buttonTakePhoto.contentHorizontalAlignment = .fill
            buttonTakePhoto.contentVerticalAlignment = .fill
            buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
            buttonTakePhoto.showsMenuAsPrimaryAction = true
            buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonTakePhoto)
        }
    
        func setupbuttonAdd(){
            buttonAdd = UIButton(type: .system)
            buttonAdd.setTitle("Add Expense", for: .normal)
            buttonAdd.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(buttonAdd)
        }
    
    
    func setupLabelAddANewTask() {
        labelAddANewTask = UILabel()
        labelAddANewTask.text = "Add a New Task"
        labelAddANewTask.font = UIFont.systemFont(ofSize:30)
        labelAddANewTask.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelAddANewTask)
    }
    
    
    func setupLabelPhoto() {
        labelPhoto = UILabel()
        labelPhoto.text = "Photo"
        labelPhoto.textColor = UIColor.gray
        labelPhoto.font = UIFont.systemFont(ofSize:20)
        labelPhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPhoto)
    }
    

    func setupTextFieldTitle() {
        textFieldTitle = UITextField()
        textFieldTitle.placeholder = "Enter Title"
        textFieldTitle.borderStyle = .roundedRect
        textFieldTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldTitle)
    }
    
    func setupTextFieldDescription() {
        textFieldDescription = UITextField()
        textFieldDescription.placeholder = "Enter Description"
        textFieldDescription.keyboardType = .emailAddress
        textFieldDescription.borderStyle = .roundedRect
        textFieldDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldDescription)
    }
    
    func setupTextFieldStatus() {
        textFieldStatus = UITextField()
        textFieldStatus.placeholder = "Status"
        textFieldStatus.keyboardType = .phonePad
        textFieldStatus.borderStyle = .roundedRect
        textFieldStatus.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldStatus)
    }
    
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
