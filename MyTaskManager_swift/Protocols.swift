import Foundation

protocol EditTaskDelegate: AnyObject {
    func didUpdateTask(_ task: Task)
}
