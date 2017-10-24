//
//  ViewController.swift
//  WhatToday
//
//  Created by Алексей on 10.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var text_field_days: UITextField!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var text_field_months: UITextField!
    
    //контент для Picker view
    let days_arr = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let months_arr = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"]
   
    //Picker view
    let my_pickerView = UIPickerView()
    
    //содержание даты
    var current_arr : [String] = []
    
    //содержание text field
    var active_textField : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text_field_months.delegate = self
        text_field_days.delegate = self
        
        my_pickerView.delegate = self
        my_pickerView.dataSource = self
        text_field_days.inputView = my_pickerView
        text_field_months.inputView = my_pickerView
        threeButton.applyDesign3()
        
        create_toolbar()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        active_textField = textField
        
        switch textField {
        case text_field_months:
            current_arr = months_arr
        case text_field_days:
            current_arr = days_arr
        default:
            print("Default")
        }
        my_pickerView.reloadAllComponents()
        
        return true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return current_arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return current_arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected item is", current_arr[row])
        active_textField.text = current_arr[row]
    }
    
    //создание toolbar
    func create_toolbar()
    {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButtom = UIBarButtonItem(title: "Принять", style: .plain, target: self, action: #selector(ViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(ViewController.cancelClick))
        toolbar.setItems([doneButtom , spaceButton, cancelButton ], animated: false)
        
        text_field_days.inputAccessoryView = toolbar
        text_field_months.inputAccessoryView = toolbar
    }
    
    //кнопка приема даты
    @objc func doneClick()
    {
        active_textField.resignFirstResponder()
    }
    
    //кнопка отмены даты
    @objc func cancelClick()
    {
        active_textField.text = ""
        active_textField.resignFirstResponder()
    }
    
}

extension UIButton{
    func  applyDesign3(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.blue, for: .normal)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
}
}

