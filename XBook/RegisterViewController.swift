//
//  RegisterViewController.swift
//  XBook
//
//  Created by Alonso Zhang on 16/4/6.
//  Copyright © 2016年 Alonso Zhang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var toplayout: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: UIButton) {
        let user = AVUser()
        user.username = self.username.text
        user.password = self.password.text
        user.email = self.email.text
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            }else{
                if error.code == 125 {
                    ProgressHUD.showError("邮箱不合法")
                }else if error.code == 203 {
                    ProgressHUD.showError("该邮箱已注册")
                }else if error.code == 202 {
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
                
            }
        }
    }
    
    @IBAction func close(sender: UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    //注册键盘出现和消失
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.toplayout.constant = 8
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.toplayout.constant = -200
            self.view.layoutIfNeeded()
        }
    }
}
