//
//  FBQuestionViewController.swift
//  FPT Banking
//
//  Created by hưng hoàng on 7/2/20.
//  Copyright © 2020 hưng hoàng. All rights reserved.
//

import UIKit

class FBQuestionViewController: FBBaseViewController {
    @IBOutlet weak var questionView1: UIView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var heightQuestionView1: NSLayoutConstraint!
    @IBOutlet weak var btnExpand1: UIButton!
    var isExpanded:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isBackgroundGray = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPress(_ sender: Any) {
        backButtonPress()
    }
    @IBAction func expandPress(_ sender: Any) {
        isExpanded = !isExpanded
        if !isExpanded {
            btnExpand1.setImage(UIImage.init(named: "ic_arrow_down"), for: .normal)
            self.heightQuestionView1.constant = 45
            lbContent.numberOfLines = 1
            

        } else {
            btnExpand1.setImage(UIImage.init(named: "ic_up_arrow"), for: .normal)
            self.heightQuestionView1.constant = 150
            lbContent.numberOfLines = 0
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
