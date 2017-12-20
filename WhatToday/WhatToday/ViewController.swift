//
//  ViewController.swift
//  WhatToday
//
//  Created by Алексей on 10.10.17.
//  Copyright © 2017 Алексей и Игорь. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {


    @IBOutlet weak var textFieldDays: UITextField!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var textFieldMonths: UITextField!
    
    
    //контент для Picker view
    let daysArr = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let monthsArr = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"]
   
    public var fileURL: URL?

    
    //Picker view
    let myPickerView = UIPickerView()
    
    //содержание даты
    var currentArr : [String] = []
    
    //содержание text field
    var activeTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldMonths.delegate = self
        textFieldDays.delegate = self
        
        myPickerView.delegate = self
        myPickerView.dataSource = self
        textFieldDays.inputView = myPickerView
        textFieldMonths.inputView = myPickerView
        
        createToolbar()
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        
        switch textField {
        case textFieldMonths:
            currentArr = monthsArr
        case textFieldDays:
            currentArr = daysArr
        default:
            print("Default")
        }
        myPickerView.reloadAllComponents()
        
        return true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentArr.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected item is", currentArr[row])
        activeTextField.text = currentArr[row]
    }
    
    //создание toolbar
    func createToolbar()
    {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let doneButtom = UIBarButtonItem(title: "Принять", style: .plain, target: self, action: #selector(ViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(ViewController.cancelClick))
        toolbar.setItems([doneButtom , spaceButton, cancelButton ], animated: false)
        
        textFieldDays.inputAccessoryView = toolbar
        textFieldMonths.inputAccessoryView = toolbar
    }
    
    //кнопка приема даты
    @objc func doneClick()
    {
        activeTextField.resignFirstResponder()
    }
    
    //кнопка отмены даты
    @objc func cancelClick()
    {
        activeTextField.text = ""
        activeTextField.resignFirstResponder()
    }

    @IBAction func buttonPressed(_ sender: Any?) {
        textFieldMonths.resignFirstResponder()
        textFieldDays.resignFirstResponder()
        performSegue(withIdentifier: "dateSend", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "dateSend" else {
            return
        }
        let secondVC = segue.destination as? SecondController
        secondVC?.dayForSearch = textFieldDays.text
        secondVC?.monthForSearch = textFieldMonths.text
    
    }
}
