//
//  Slider.swift
//  26Tracking
//
//  Created by Taras on 11/6/16.
//  Copyright © 2016 Taras. All rights reserved.
//

import UIKit

class Slider: UISlider {

    override func awakeFromNib() {
        
        self.transform = CGAffineTransform.init(rotationAngle: CGFloat(CFloat(-M_PI/2)))
    }

}
