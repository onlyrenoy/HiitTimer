//
//  Home.swift
//  HiitTimer
//
//  Created by Renoy Chowdhury on 24/08/24.
//

import UIKit

class BasePicker: UIView {
    var pickerData: [String] = []
    var picker = UIPickerView()
    var selected = ""
    
    convenience init(_ pickerData: [String]) {
        self.init()
        
        self.pickerData = pickerData
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        subviews(picker)
        picker.fillContainer()
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BasePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selected = String(pickerData[row])
        return String(pickerData[row])
    }
}

class Home: UIViewController {
    var repetitionLabel = UILabel()
    var exerciseLabel = UILabel()
    var restLabel = UILabel()
    
    var repetitionPicker = BasePicker(["1", "2", "3", "4", "5", "6", "7", "8"])
    var exercisePicker = BasePicker(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    var restPicker = BasePicker(["10", "20", "30", "40", "50", "60", "70", "80", "90"])
    
    var button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        button.setTitle("OK", for: .normal)
        button.addTarget(self, action: #selector(tapOnOk), for: .touchUpInside)
        button.backgroundColor = .red
        
        repetitionLabel.text = "Repetition"
        exerciseLabel.text = "Exercise"
        restLabel.text = "Rest"
        
        view.subviews(repetitionLabel, repetitionPicker, exerciseLabel, exercisePicker, restLabel, restPicker, button)
        
        view.layout(
            90,
            |-repetitionLabel-| ~ 20,
            |-repetitionPicker-| ~ 100,
            10,
            |-exerciseLabel-| ~ 20,
            |-exercisePicker-| ~ 100,
            10,
            |-restLabel-| ~ 20,
            |-restPicker-| ~ 100,
            "",
            |-button-| ~ 52,
            50
        )
    }
    
    @objc
    func tapOnOk() {
        let vc = ViewController()
        vc.times = Times(exercise: Double(exercisePicker.selected) ?? 0, rest: Double(restPicker.selected) ?? 0)
        vc.repeatedTimes = Int(repetitionPicker.selected) ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
}
