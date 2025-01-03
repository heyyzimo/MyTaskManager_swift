import UIKit

class EditTaskScreenView: UIView {
    
    // UI elements
    let titleTextField = UITextField()
    let descriptionTextField = UITextField()
    let statusTextField = UITextField()
    let photoButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // Setup the layout and appearance of the UI elements
    private func setupView() {
        // Set the background color
        backgroundColor = .white

        // Customize each text field
        titleTextField.placeholder = "Enter title"
        titleTextField.borderStyle = .roundedRect

        descriptionTextField.placeholder = "Enter description"
        descriptionTextField.borderStyle = .roundedRect

        statusTextField.placeholder = "Enter status"
        statusTextField.borderStyle = .roundedRect


        // Customize the photo button
        photoButton.setTitle("Select Photo", for: .normal)
        photoButton.setTitleColor(.blue, for: .normal)
        photoButton.layer.cornerRadius = 10
        photoButton.layer.borderWidth = 1
        photoButton.layer.borderColor = UIColor.lightGray.cgColor

        // Add the subviews
        addSubview(titleTextField)
        addSubview(descriptionTextField)
        addSubview(statusTextField)
 
        addSubview(photoButton)

        // Set up AutoLayout constraints for each UI element
        setupConstraints()
    }

    private func setupConstraints() {
        // Disable autoresizing mask for AutoLayout
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
       
        photoButton.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints for the UI elements
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

            statusTextField.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 20),
            statusTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            
        ])
    }
}
