//
//  BaseUIViewController+BaseView.swift
//  AmahiAnywhere
//
//  Created by codedentwickler on 2/17/18.
//  Copyright © 2018 Amahi. All rights reserved.


import UIKit
import MBProgressHUD


// Mark - Generic View Setup 
extension BaseUIViewController: BaseView {
    
    func showLoading() {
        showProgressIndicator(withMessage: StringLiterals.PLEASE_WAIT)
    }
    
    func showLoading(withMessage text: String) {
        showProgressIndicator(withMessage: text)
    }
    
    func dismissLoading() {
        dismissProgressIndicator()
    }
    
    func showError(title: String, message text: String) {
        createErrorDialog(title: title, message: text)
    }
    
    func showError(message text: String) {
        createErrorDialog(message: text)
    }
    
    func isNetworkConnected() {}
}


// Mark - Common View Actions

extension UIViewController {
    
    func performSegue(identifier: String) {
        OperationQueue.main.addOperation {
            [weak self] in
            self?.performSegue(withIdentifier: identifier, sender: self);
        }
    }
    
    func instantiateViewController(withIdentifier id : String, from storyBoardName: String) -> UIViewController {
        // Get the Storyboard with id and Create View COntroller with parameter name -> storyBoardName
        let storyboard = UIStoryboard (name: storyBoardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: id)

        return vc
    }

    
    func createErrorDialog(title: String! = "Oops!", message: String! = StringLiterals.GENERIC_NETWORK_ERROR) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        alertController.addAction(defaultAction);
       
                
        self.present(alertController, animated: true, completion: nil);
    }
    
    func creatAlertAction(_ title: String! = "Ok", style: UIAlertActionStyle = .default, clicked: ((_ action: UIAlertAction) -> Void)?) -> UIAlertAction! {
        return UIAlertAction(title: title, style: style, handler: clicked);
    }
}

// MARK - Progress Loading Indicator

extension BaseUIViewController {
    
    func showProgressIndicator(withMessage message: String) {
        self.view.endEditing(true)
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.mode = MBProgressHUDMode.indeterminate
        hud.isUserInteractionEnabled = false
        showNetworkIndicator(status: true)
    }
    
    func dismissProgressIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        showNetworkIndicator(status: false)
    }
    
    func showNetworkIndicator(status: Bool = true) {
        OperationQueue.main.addOperation {
            [weak self] in
            _ = self.debugDescription
            UIApplication.shared.isNetworkActivityIndicatorVisible = status;
        }
    }
}
