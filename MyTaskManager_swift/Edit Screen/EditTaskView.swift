import UIKit

class EditTaskScreenView: UIView {
    
    // UI elements
    let titleTextField = UITextField()
    let descriptionTextField = UITextField()
    let statusSwitch = UISwitch()  // Toggle for status
    let statusLabel = UILabel()    // Label for switch
    let photoButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Set the background color
        backgroundColor = .white

        // Customize each text field
        titleTextField.placeholder = "Enter title"
        titleTextField.borderStyle = .roundedRect

        descriptionTextField.placeholder = "Enter description"
        descriptionTextField.borderStyle = .roundedRect

        // Customize the status switch
        statusLabel.text = "Task Completed"
        statusLabel.font = UIFont.systemFont(ofSize: 16)
        statusSwitch.isOn = false // Default to Pending

        // Customize the photo button
        photoButton.setTitle("Select Photo", for: .normal)
        photoButton.setTitleColor(.blue, for: .normal)
        photoButton.layer.cornerRadius = 10
        photoButton.layer.borderWidth = 1
        photoButton.layer.borderColor = UIColor.lightGray.cgColor

        // Add the subviews
        addSubview(titleTextField)
        addSubview(descriptionTextField)
        addSubview(statusSwitch)
        addSubview(statusLabel)
        addSubview(photoButton)

        // Set up AutoLayout constraints for each UI element
        setupConstraints()
    }

    private func setupConstraints() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        statusSwitch.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        photoButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            photoButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            photoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoButton.widthAnchor.constraint(equalToConstant: 100),
            photoButton.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionTextField.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40),

            statusSwitch.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            statusSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            statusLabel.centerYAnchor.constraint(equalTo: statusSwitch.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: statusSwitch.trailingAnchor, constant: 10),
        ])
    }
}
