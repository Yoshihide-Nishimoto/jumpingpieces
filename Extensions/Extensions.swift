//
//  File.swift
//  pyonpyon
//
//  Created by 西本至秀 on 2019/01/06.
//  Copyright © 2019 jp.co.wbcompany. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func boardColor()->UIColor{
        return getColorByRGB(red: 255, green: 243, blue: 184, alpha: 1)
    }
    
    class func boaderColor()->UIColor{
        return getColorByRGB(red: 131, green: 130, blue: 90, alpha: 1)
    }
    
    class func player1()->UIColor{
        return getColorByRGB(red: 217, green: 218, blue: 100, alpha: 1)
    }
    
    class func player2()->UIColor{
        return getColorByRGB(red: 253, green: 170, blue: 143, alpha: 1)
    }
    
    class func movable()->UIColor{
        return getColorByRGB(red: 200, green: 200, blue: 200, alpha: 0.5)
    }

    class func getColorByRGB(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}
