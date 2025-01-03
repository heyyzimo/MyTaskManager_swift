

import Foundation
import UIKit

struct Task{
    var title: String?
    var description: String?
    var status: String?
    
    var image: UIImage?

    
    init(title: String? = nil, description: String? = nil,  status: String? = nil, number: String? = nil, address: String? = nil, cityState: String? = nil, zip: String? = nil, image: UIImage) {
        self.title = title
        self.description = description
        
        self.status = status
    
        
        self.image = image

        
    }
    
}

