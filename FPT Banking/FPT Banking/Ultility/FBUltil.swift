//
//  Ultility.swift
//  FPT Banking
//
//  Created by hưng hoàng on 6/18/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import Foundation
import UIKit

final class FBUltil {
    static var share = FBUltil()
    var iPhoneStorybroard = UIStoryboard(name: "ElearninglPhone", bundle: nil)
    //MARK: check storyboard Elearning
    var storyboard: UIStoryboard {
        return self.iPhoneStorybroard
            }
    
    // MARK: get vc elearnig
//    func getVcElearning() -> ElearningViewController {
//        return storyboard.instantiateViewController(withIdentifier: "ElearningViewController") as! ElearningViewController
//    }
    
    //Mark: get Operation OJT
//    func getActivityOJT() -> UIViewController {
//        var vc = UIViewController()
//        if WTUtilitys.isIpad() {
//            vc = storyboard.instantiateViewController(withIdentifier: "HDActivityOJTIpadViewController")
//        }
//        else {
//            vc = storyboard.instantiateViewController(withIdentifier: "HDActivityOJTViewController")
//        }
//        return vc
//    }
    

}

