//
//  ViewController.swift
//  Picker
//
//  Created by Alex Han on 07.07.2021.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet private weak var genderTextField: UITextField!
    @IBOutlet private weak var dateOfBirthTextField: UITextField!
  
    private let gender = ["Male", "Female", "Unknown"]
    private let genderPicker = UIPickerView()
    private let dateOfBirthPicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupElements() // чтобы не засорять view.DidLoad(), вынес заполнение в отдельную приватную ф-цию
        
    }
    
    @IBAction func genderTouchUp(_ sender: Any) {
        if genderTextField.isFirstResponder {
            genderTextField.resignFirstResponder()
        }
        
        genderTextField.becomeFirstResponder()
    }
    
    @IBAction func dateOfBirthTouchUp(_ sender: Any) {
        if dateOfBirthTextField.isFirstResponder {
            dateOfBirthTextField.resignFirstResponder()
        }
        
        dateOfBirthTextField.becomeFirstResponder()
    }
    
    private func setupElements(){
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        dateOfBirthPicker.date = Date()
        dateOfBirthPicker.datePickerMode = .date
        dateOfBirthPicker.preferredDatePickerStyle = .wheels
        
        dateOfBirthPicker.minimumDate = Calendar.current.date(byAdding: .year, value: -80, to: Date())
        dateOfBirthPicker.maximumDate = Date()
        
        dateOfBirthPicker.addTarget(self, action: #selector(dateOfBirth(pickerDidChange:)),
                                 for: .valueChanged)

        genderTextField.inputView = genderPicker
        dateOfBirthTextField.inputView = dateOfBirthPicker
        
        avatar.image = #imageLiteral(resourceName: "Default")
        
        avatar.layer.cornerRadius = avatar.frame.height / 2
        
        doneButtonForPickers()
    }
    
    
    @objc func dateOfBirth(pickerDidChange: UIDatePicker) {
         let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateOfBirthTextField.text = formatter.string(from: dateOfBirthPicker.date)
     }
    
    func doneButtonForPickers() {
        let doneButton = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker))
        dateOfBirthTextField.inputAccessoryView = doneButton
        genderTextField.inputAccessoryView = doneButton
    }
    
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = gender[row]
        
        if genderTextField.text == "Male" {
            avatar.image = #imageLiteral(resourceName: "Male")
        }
        if genderTextField.text == "Female" {
            avatar.image = #imageLiteral(resourceName: "Female")
        }
        if genderTextField.text == "Unknown" {
            avatar.image = #imageLiteral(resourceName: "Unknown")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
}


