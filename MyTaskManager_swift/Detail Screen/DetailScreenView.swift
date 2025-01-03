
import UIKit

class DetailScreenView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var labelTitle: UILabel!
    var labelDescription: UILabel!
    var labelStatus: UILabel!
 
    
    var imageReceipt: UIImageView!


    // MARK: View initializer
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Setting the background color
        self.backgroundColor = .white
        
        setupScrollView()


        // Initializing the UI elements
        setupLabelTitle()
        setupLabelDescription()
        setupLabelStatus()

        
        setupimageReceipt()

        // Initializing constraints
        initConstraints()
    }
    
    
    
    
    
    func setupimageReceipt(){
            imageReceipt = UIImageView()
            imageReceipt.image = UIImage(systemName: "photo")
            imageReceipt.contentMode = .scaleToFill
            imageReceipt.clipsToBounds = true
            imageReceipt.layer.cornerRadius = 10
            imageReceipt.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(imageReceipt)
        }
    
    
    func setupScrollView() {
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(scrollView)
            
            // Constrain scroll view to edges of DetailScreenView
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            
            // Set up the content view inside the scroll view
            contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            // Constrain content view to the scroll view
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        }

    // MARK: Initializing the UI elements
    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.textAlignment = .left
        labelTitle.font = UIFont.boldSystemFont(ofSize: 24) // Set the font to bold with size 16
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTitle)
    }

    func setupLabelDescription() {
        labelDescription = UILabel()
        labelDescription.textAlignment = .left
        labelDescription.font = UIFont.systemFont(ofSize: 16)
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelDescription)
    }

    func setupLabelStatus() {
        labelStatus = UILabel()
        labelStatus.textAlignment = .left
        labelStatus.font = labelStatus.font.withSize(16)
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelStatus)
    }

  


    // MARK: Initializing the constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            imageReceipt.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageReceipt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageReceipt.widthAnchor.constraint(equalToConstant: 100),
            imageReceipt.heightAnchor.constraint(equalToConstant: 100),
            
            
            // Constraints for labelTitle
            labelTitle.topAnchor.constraint(equalTo: imageReceipt.bottomAnchor, constant: 32),
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            // Constraints for labelDescription
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),


            // Constraints for labelStatus
            labelStatus.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            labelStatus.centerXAnchor.constraint(equalTo: self.centerXAnchor),


            
        ])
    }
    
   

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
