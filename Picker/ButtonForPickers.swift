//
//  ButtonsForPickers.swift
//  Picker
//
//  Created by Alex Han on 08.07.2021.
//

import UIKit


extension UIToolbar {

    func toolbarPiker(mySelect : Selector) -> UIToolbar {

        let toolBar = UIToolbar()

        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: mySelect)
    
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }

}
