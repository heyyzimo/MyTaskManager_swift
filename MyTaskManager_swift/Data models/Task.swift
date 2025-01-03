

import Foundation
import UIKit

struct Task{
    var id: UUID
    var title: String?
    var description: String?
    var status: String?
    
    var image: UIImage?

    
    init(title: String? = nil, description: String? = nil,  status: String? = nil, number: String? = nil, address: String? = nil, cityState: String? = nil, zip: String? = nil, image: UIImage) {
        self.id = UUID() // Automatically generate a unique ID for each task
        self.title = title
        self.description = description
        
        self.status = status
    
        
        self.image = image

        
    }
    
}

