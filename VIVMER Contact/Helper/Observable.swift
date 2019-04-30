//
//  Observablt
//
//  Created by UziApel on 07/02/19.
//  Copyright © 2019 uzi. All rights reserved.
//

import Foundation


class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    private var valueChanged: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func addObserver(open: Bool = true, _ onChange: ((T) -> Void)?) {
        valueChanged = onChange
        if open {
            onChange?(value)
        }
    }
    
    func removeObserver() {
        valueChanged = nil
    }
    
}
