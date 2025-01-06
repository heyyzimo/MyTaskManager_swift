
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
        // 设置阴影偏移量，这里为 `.zero`，表示阴影与视图完全重叠（无偏移）
        wrapperCellView.layer.shadowOffset = .zero
        // 设置阴影的模糊半径，值越大，阴影越柔和
        wrapperCellView.layer.shadowRadius = 6.0
        // 设置阴影的不透明度，0 表示完全透明，1 表示完全不透明
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
        
    
    // MARK: - Unused Methods

    // 视图从 Interface Builder 加载时会调用此方法
    required init?(coder: NSCoder) {
        // 因为我们不使用 Storyboard 或 XIB 文件，所以抛出错误
        fatalError("init(coder:) has not been implemented")
    }

    // 视图从 NIB 或 Storyboard 加载完成后会调用此方法
    override func awakeFromNib() {
        super.awakeFromNib()
        // 此处可添加视图的额外初始化代码（如果需要）
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
