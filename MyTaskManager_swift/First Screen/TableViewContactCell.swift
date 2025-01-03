
import UIKit

class TableViewTaskCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelTitle: UILabel!
    var labelDescription: UILabel!
    var labelStatus : UILabel!
    
    var imageReceipt: UIImageView!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupLabelTitle()
        setupLabelDescription()
        setupLabelStatus()
        
        setupimageReceipt()
        
        initConstraints()


    }
    
    func setupimageReceipt(){
            imageReceipt = UIImageView()
            imageReceipt.image = UIImage(systemName: "photo")
            imageReceipt.contentMode = .scaleToFill
            imageReceipt.clipsToBounds = true
            imageReceipt.layer.cornerRadius = 10
            imageReceipt.translatesAutoresizingMaskIntoConstraints = false
            wrapperCellView.addSubview(imageReceipt)
        }
    
    
    
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 10.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 6.0
        wrapperCellView.layer.shadowOpacity = 0.7
        
        
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    
    func setupLabelTitle(){
            labelTitle = UILabel()
            labelTitle.font =
            UIFont.boldSystemFont(ofSize: 20)
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            wrapperCellView.addSubview(labelTitle)
        }
    func setupLabelDescription(){
        labelDescription = UILabel()
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDescription)
    }
    
    
    func setupLabelStatus(){
        labelStatus = UILabel()
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelStatus)
    }
        
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func initConstraints(){
           NSLayoutConstraint.activate([
//               wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
//               wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//               wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//               wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
       
                
                  
               labelTitle.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
               labelTitle.leadingAnchor.constraint(equalTo: imageReceipt.trailingAnchor, constant: 4),
               labelTitle.heightAnchor.constraint(equalToConstant: 20),
               
               labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 8),
               labelDescription.leadingAnchor.constraint(equalTo: imageReceipt.trailingAnchor),
               labelDescription.heightAnchor.constraint(equalToConstant: 20),
               
               labelStatus.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 4),
               labelStatus.leadingAnchor.constraint(equalTo: imageReceipt.trailingAnchor),
               labelStatus.heightAnchor.constraint(equalToConstant: 20),
               
               
               imageReceipt.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
               imageReceipt.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
               //MARK: it is better to set the height and width of an ImageView with constraints...
               imageReceipt.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
               imageReceipt.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
               
                wrapperCellView.heightAnchor.constraint(equalToConstant: 104)

           ])
       }

}
