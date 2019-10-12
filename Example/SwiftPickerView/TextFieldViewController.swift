//
//  TextFieldViewController.swift
//  SwiftPickerView
//
//  Created by CoderDoraemon on 10/11/2019.
//  Copyright (c) 2019 CoderDoraemon. All rights reserved.
//
import UIKit

class TextFieldViewController: UIViewController {

    @IBOutlet weak var singleTextField: SelectionTextField!
    @IBOutlet weak var multipleTextField: SelectionTextField!
    @IBOutlet weak var multipleAssociatedTextField: SelectionTextField!
    @IBOutlet weak var citiesTextField: SelectionTextField!
    @IBOutlet weak var dateTextField: SelectionTextField!
    @IBOutlet weak var timeTextField: SelectionTextField!

    @IBOutlet weak var selectedDataLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singleTextField.showSingleColPicker("编程语言选择", data: singleData, defaultSelectedIndex: 2, autoSetSelectedText: true) {[unowned self] (textField, selectedIndex, selectedValue) in
            //  可以使用textField 也可以使用 self.singleTextField
            textField.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"
            self.selectedDataLabel.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"

        }
        
        
        multipleTextField.showMultipleColsPicker("持续时间选择", data: multipleData, defaultSelectedIndexs: [0,1,1], autoSetSelectedText: true) { [unowned self] (textField, selectedIndexs, selectedValues) in
            self.multipleTextField.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"
            
        }
        
        
        // 注意这里设置的是默认的选中值, 而不是选中的下标
        multipleAssociatedTextField.showMultipleAssociatedColsPicker("多列关联数据", data: multipleAssociatedData, defaultSelectedValues: ["交通工具","陆地","自行车"], autoSetSelectedText: true) {[unowned self] (textField, selectedIndexs, selectedValues) in
            self.multipleAssociatedTextField.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"

        }
        
        // 注意设置默认值得时候, 必须设置完整, 不能进行省略 ["四川", "成都", "成华区"] 比如不能设置为["四川", "成都"]
        // ["北京", "通州"] 不能设置为["北京"]
        citiesTextField.showCitiesPicker("省市区选择", defaultSelectedValues: ["四川", "成都", "郫县"], autoSetSelectedText: false) {[unowned self] (textField, selectedIndexs, selectedValues) in
            self.citiesTextField.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"

        }
        
        dateTextField.showDatePicker("日期选择", autoSetSelectedText: true) { (textField, selectedDate) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.string(from: selectedDate)
            textField.text = string
        }
        
        // style里面可以更改的和系统的DatePicker属性是一一对应的
        var dateStyle = DatePickerSetting()
        dateStyle.dateMode = .date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: "2000-01-11")
        dateStyle.date = date!
        
        /// 注意使用这种方式的时候, 请设置 autoSetSelectedText = false, 否则显示的格式可能不是您需要的
        timeTextField.showDatePicker("时间选择", datePickerSetting: dateStyle, autoSetSelectedText: false) { (textField, selectedDate) in
            let formatter = DateFormatter()
            // H -> 24小时制
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.string(from: selectedDate)
            textField.text = string
        }
        

    }
}

