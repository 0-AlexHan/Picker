//
//  ViewController.swift
//  Picker
//
//  Created by Alex Han on 07.07.2021.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var genderTextField: UITextField!
    @IBOutlet private weak var dateOfBirthTextField: UITextField!
  
    private let gender: [Gender] = [.male, .female, .unknown]
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
        let yearRange = -80
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        dateOfBirthPicker.date = Date()
        dateOfBirthPicker.datePickerMode = .date
        dateOfBirthPicker.preferredDatePickerStyle = .wheels
        
        dateOfBirthPicker.minimumDate = Calendar.current.date(byAdding: .year, value: yearRange, to: Date())
        dateOfBirthPicker.maximumDate = Date()
        
        dateOfBirthPicker.addTarget(self, action: #selector(dateOfBirth(pickerDidChange:)),
                                 for: .valueChanged)

        genderTextField.inputView = genderPicker
        dateOfBirthTextField.inputView = dateOfBirthPicker
        
        avatar.image = #imageLiteral(resourceName: "Default")
        
        avatar.layer.cornerRadius = avatar.bounds.width / 2
        
        doneButtonForPickers()
    }
    
    
    @objc func dateOfBirth(pickerDidChange: UIDatePicker) {
         let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateOfBirthTextField.text = formatter.string(from: dateOfBirthPicker.date)
     }
    
    func doneButtonForPickers() {
        let doneButton = UIToolbar().toolbarPiker(mySelect: #selector(dismissPicker))
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
        genderTextField.text = gender[row].rawValue
        
        guard let textFromPicker = genderTextField.text else {
            return
        }
        
        let genderText = Gender(rawValue: textFromPicker)
        
        switch genderText {
            case .male:
                avatar.image = #imageLiteral(resourceName: "Male")
            case .female:
                avatar.image = #imageLiteral(resourceName: "Female")
            case .unknown:
                avatar.image = #imageLiteral(resourceName: "Unknown")
            default:
                avatar.image = #imageLiteral(resourceName: "Default")
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row].rawValue
    }
}


