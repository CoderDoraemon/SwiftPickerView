//
//  ViewController.swift
//  SwiftPickerView
//
//  Created by CoderDoraemon on 10/11/2019.
//  Copyright (c) 2019 CoderDoraemon. All rights reserved.
//

import UIKit

let singleData = ["swift", "ObjecTive-C", "C", "C++", "java", "php", "python", "ruby", "js"]
// 每一列为数组
let multipleData = [["1天", "2天", "3天", "4天", "5天", "6天", "7天"],["1小时", "2小时", "3小时", "4小时", "5小时"],  ["1分钟","2分钟","3分钟","4分钟","5分钟","6分钟","7分钟","8分钟","9分钟","10分钟"]]

// 注意这个数据的格式!!!!!!
let multipleAssociatedData: [[[String: [String]?]]] = [// 数组
    
    [   ["交通工具": ["陆地", "空中", "水上"]],//字典
        ["食品": ["健康食品", "垃圾食品"]],
        ["游戏": ["益智游戏", "角色游戏"]]
        
    ],// 数组
    
    [   ["陆地": ["公交车", "小轿车", "自行车"]],
        ["空中": ["飞机"]],
        ["水上": ["轮船"]],
        ["健康食品": ["蔬菜", "水果"]],
        ["垃圾食品": ["辣条", "不健康小吃"]],
        ["益智游戏": ["消消乐", "消灭星星"]],
        ["角色游戏": ["lol", "cf"]]
        
    ]
]

class ViewController: UIViewController {

    
    @IBOutlet weak var selectedDataLabel: UILabel!
    
    
    @IBAction func singleBtnOnClick(_ sender: UIButton) {
        
        PickerViewManager.showSingleColPicker("编程语言选择", data: singleData, defaultSelectedIndex: 2) {[unowned self] (selectedIndex, selectedValue) in
            self.selectedDataLabel.text = "选中了第\(selectedIndex)行----选中的数据为\(selectedValue)"
        }
        
    }
    @IBAction func multipleBtnOnClick(_ sender: UIButton) {
        
        
        PickerViewManager.showMultipleColsPicker("持续时间选择", data: multipleData, defaultSelectedIndexs: [0,1,1]) {[unowned self] (selectedIndexs, selectedValues) in
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"

        }
        
    }
    @IBAction func multipleAssociatedBtnOnClick(_ sender: UIButton) {
        
        // 注意这里设置的是默认的选中值, 而不是选中的下标,省得去数关联数组里的下标
        PickerViewManager.showMultipleAssociatedColsPicker("多列关联数据", data: multipleAssociatedData, defaultSelectedValues: ["交通工具","陆地","自行车"]) {[unowned self] (selectedIndexs, selectedValues) in
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(selectedValues)"
            
        }
        
    }
    @IBAction func citiesBtnOnClick(_ sender: UIButton) {
        // 注意设置默认值得时候, 必须设置完整, 不能进行省略 ["四川", "成都", "成华区"] 比如不能设置为["四川", "成都"]
        // ["北京", "通州"] 不能设置为["北京"]
        PickerViewManager.showCitiesPicker("省市区选择", defaultSelectedValues: ["北京", "/", "/"], selectTopLevel: true) {[unowned self] (selectedIndexs, selectedValues) in
            // 处理数据
            let combinedString = selectedValues.reduce("", { (result, value) -> String in
                result + " " + value
            })
            
            self.selectedDataLabel.text = "选中了第\(selectedIndexs)行----选中的数据为\(combinedString)"
            
        }
    }
    @IBAction func dateBtnOnClick(_ sender: UIButton) {
        
        
        PickerViewManager.showDatePicker("日期选择") {[unowned self] ( selectedDate) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.string(from: selectedDate)
            self.selectedDataLabel.text = "选中了的日期是\(string)"
        }
        

    }
    
    @IBAction func timeBtnOnClick(_ sender: UIButton) {
        
        // style里面可以更改的和系统的DatePicker属性是一一对应的
        var dateStyle = DatePickerSetting()
        dateStyle.dateMode = .time
        
        PickerViewManager.showDatePicker("时间选择", datePickerSetting: dateStyle) { (selectedDate) in
            let formatter = DateFormatter()
            // H -> 24小时制
            formatter.dateFormat = "HH: mm"
            let string = formatter.string(from: selectedDate)
            self.selectedDataLabel.text = "选中了的日期是\(string)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}



