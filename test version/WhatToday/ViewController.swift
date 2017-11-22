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


    @IBOutlet weak var text_field_days: UITextField!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var text_field_months: UITextField!
    
    
    //контент для Picker view
    let days_arr = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let months_arr = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"]
   
    public var fileURL: URL?
    
    
    //Picker view
    let my_pickerView = UIPickerView()
    
    //содержание даты
    var current_arr : [String] = []
    
    //содержание text field
    var active_textField : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvent()
      
        
    print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        text_field_months.delegate = self
        text_field_days.delegate = self
        
        my_pickerView.delegate = self
        my_pickerView.dataSource = self
        text_field_days.inputView = my_pickerView
        text_field_months.inputView = my_pickerView
 
        
        create_toolbar()
        
    }
    
    func addEvent(){
        /*let adddata = EventsDB()
        adddata.dataMonth = "Апрель"
        adddata.dataDay = "1"
        adddata.desc = ""
        adddata.link = ""
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(adddata)
            print("Added\(adddata.dataMonth) to Realm")
        }*/
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
        
         let realm = try! Realm()
        let events = realm.objects(EventsDB.self)
        //let predicate = NSPredicate(format: "dateMonth BEGINSWITH 'Апр'")
        
        
        
          if ((text_field_months.text) == "Апрель")
        {
            print(events.filter("dataMonth = 'Апрель'").sorted(byKeyPath: "dataDay", ascending: true))
            print("События найдены")
            
        }
        if ((text_field_months.text) == "Декабрь")
        {
            print(events.filter("dataMonth = 'Декабрь'").sorted(byKeyPath: "dataDay", ascending: true))
            print("События найдены")
            
        }
        else{
            print("События не найдены")
        }
        
        
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
    
    @IBAction func buttonPressed(_ sender: Any?) {
        text_field_months.resignFirstResponder()
        print(text_field_months.text)
        performSegue(withIdentifier: "dateSend", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "dateSend" else {
            return
        }
        let secondVC = segue.destination as? SecondController
        secondVC?.monthForSearch = text_field_months.text
    
    }
}

