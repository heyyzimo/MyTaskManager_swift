import UIKit

class DetailScreenView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var labelTitle: UILabel!
    var labelDescription: UILabel!
    var labelStatus: UILabel!
    var imageReceipt: UIImageView!
    
    // New Delete Button
    var buttonDelete: UIButton!

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
        setupButtonDelete() // Add the delete button

        // Initializing constraints
        initConstraints()
    }

    func setupimageReceipt() {
        // 创建一个 UIImageView 实例，用于显示图片
        imageReceipt = UIImageView()
        
        // 设置默认图像，这里使用了系统的 "photo" 图标
        imageReceipt.image = UIImage(systemName: "photo")
        
        // 设置内容模式为填充，这样图像会根据 UIImageView 的尺寸拉伸或压缩
        imageReceipt.contentMode = .scaleToFill
        
        // 设置 clipsToBounds 为 true，确保子内容不会超出 UIImageView 的边界
        imageReceipt.clipsToBounds = true
        
        // 设置圆角半径为 10，使 UIImageView 的四角变圆
        imageReceipt.layer.cornerRadius = 10
        
        // 禁用自动将 autoresizing mask 转换为约束，这样可以使用 Auto Layout 手动设置约束
        imageReceipt.translatesAutoresizingMaskIntoConstraints = false
        
        // 将 UIImageView 添加到当前视图 (self) 中
        self.addSubview(imageReceipt)
    }


    func setupScrollView() {
        // 创建一个 UIScrollView 实例，用于支持内容的滚动
        scrollView = UIScrollView()
        
        // 禁用 autoresizing mask 转换为约束，以便手动设置 Auto Layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // 将 UIScrollView 添加到当前视图 (self) 中
        self.addSubview(scrollView)
        
        // 使用 Auto Layout 将 scrollView 的边界约束到当前视图的安全区域边界
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // 创建一个内容视图 (contentView)，它将包含需要滚动的所有子视图
        contentView = UIView()
        
        // 禁用 contentView 的 autoresizing mask 转换为约束，以便手动设置 Auto Layout
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // 将 contentView 添加到 scrollView 中
        scrollView.addSubview(contentView)
        
        // 使用 Auto Layout 将 contentView 约束到 scrollView 的边界
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // 确保 contentView 的宽度始终等于 scrollView 的宽度
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }


    func setupLabelTitle() {
        labelTitle = UILabel()
        labelTitle.textAlignment = .left
        labelTitle.font = UIFont.boldSystemFont(ofSize: 24)
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

    // New Setup Method for Delete Button
    func setupButtonDelete() {
        buttonDelete = UIButton(type: .system)
        buttonDelete.setTitle("Delete Task", for: .normal)
        buttonDelete.setTitleColor(.red, for: .normal)
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonDelete)
    }

    // MARK: Initializing the constraints
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Image Receipt Constraints
            imageReceipt.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageReceipt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageReceipt.widthAnchor.constraint(equalToConstant: 100),
            imageReceipt.heightAnchor.constraint(equalToConstant: 100),
            
            // Title Label Constraints
            labelTitle.topAnchor.constraint(equalTo: imageReceipt.bottomAnchor, constant: 32),
            labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            // Description Label Constraints
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            labelDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            // Status Label Constraints
            labelStatus.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 20),
            labelStatus.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            // Delete Button Constraints
            buttonDelete.topAnchor.constraint(equalTo: labelStatus.bottomAnchor, constant: 40),
            buttonDelete.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonDelete.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    //父类要求：许多 UIKit 类（如 UIView, UIViewController）都要求提供 init(coder:) 初始化器，以支持从 Nib 或 Storyboard 文件加载视图。
    //为了解码视图时的兼容性需求。
    //coder: NSCoder 是解码器，用于从已保存的 Nib 或 Storyboard 文件中加载对象。
    required init?(coder: NSCoder) {
        //错误信息, 这个类不支持通过 init(coder:) 初始化。表示该类不支持从 Interface Builder 加载，避免误用。
        fatalError("init(coder:) has not been implemented")
    }
}
