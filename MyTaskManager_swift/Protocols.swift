import Foundation
//protocol 定义了一组标准，任何类型只要遵守这个协议，就必须实现其要求的方法和属性。
//if you use these 2 delegates, you must be able to use these 2 functions
//避免重复这些代码在很多file
protocol EditTaskDelegate: AnyObject {
    //_ task：表示更新后的任务，类型为 Task。
    //_ 表示调用方法时不需要显式地写出参数标签（调用时直接 didUpdateTask(task)）。
    func didUpdateTask(_ task: Task)
}

protocol TaskDeletionDelegate: AnyObject {
    func didDeleteTask(_ taskID: UUID)
}
