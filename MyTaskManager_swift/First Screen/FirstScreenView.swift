
import UIKit

class FirstScreenView: UIView {
    
    var tableViewTask: UITableView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupTableViewTask()
        initConstraints()
    }
    
    func setupTableViewTask(){
        tableViewTask = UITableView()
        tableViewTask.register(TableViewTaskCell.self, forCellReuseIdentifier: "tasks")
        tableViewTask.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewTask)
    }
    
    //MARK: setting the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewTask.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewTask.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewTask.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewTask.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
