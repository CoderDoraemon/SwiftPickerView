//
//  SelectionTextField.swift
//  SwiftPickerView
//
//  Created by CoderDoraemon on 10/11/2019.
//  Copyright (c) 2019 CoderDoraemon. All rights reserved.
//

#if canImport(UIKit)
import UIKit

open class SelectionTextField: UITextField {

    public typealias BtnAction = () -> Void
    public typealias SingleDoneAction = (_ textField: UITextField, _ selectedIndex: Int, _ selectedValue: String) -> Void
    public typealias MultipleDoneAction = (_ textField: UITextField, _ selectedIndexs: [Int], _ selectedValues: [String]) -> Void
    public typealias DateDoneAction = (_ textField: UITextField, _ selectedDate: Date) -> Void
    
    public typealias MultipleAssociatedDataType = [[[String: [String]?]]]
    
    ///  保存pickerView的初始化
    fileprivate var setUpPickerClosure:(() -> PickerView)?
    ///  如果设置了autoSetSelectedText为true 将自动设置text的值, 默认以空格分开多列选择, 但你仍然可以在响应完成的closure中修改text的值
    fileprivate var autoSetSelectedText = false
    
    //MARK: 初始化
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    // 从xib或storyboard中初始化时候调用
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("\(self.debugDescription) --- 销毁")
    }


}

// MARK: - 监听通知
extension SelectionTextField {
    
    fileprivate func commonInit() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBeginEdit), name: UITextField.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEndEdit), name: UITextField.textDidEndEditingNotification, object: self)
    }
    // 开始编辑添加pickerView
    @objc
    func didBeginEdit()  {
        let pickerView = setUpPickerClosure?()
        pickerView?.delegate = self
        inputView = pickerView
    }
    // 编辑完成销毁pickerView
    @objc
    func didEndEdit() {
        inputView = nil
    }
    
    override open func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
}

// MARK: - 使用方法
extension SelectionTextField {
    
    /// 单列选择器
    /// - Parameter toolBarTitle: 标题
    /// - Parameter data: 数据
    /// - Parameter defaultSelectedIndex: 默认选中的行数
    /// - Parameter autoSetSelectedText: 设置为true的时候, 将按默认的格式自动设置textField的值
    /// - Parameter doneAction: 响应完成的Closure
    public func showSingleColPicker(_ toolBarTitle: String, data: [String], defaultSelectedIndex: Int?,autoSetSelectedText: Bool, doneAction: SingleDoneAction?) {
        
        self.autoSetSelectedText = autoSetSelectedText

        // 保存在这个closure中, 在开始编辑的时候在执行, 避免像之前在这里直接初始化pickerView, 每个SelectionTextField在调用这个方法的时候就初始化pickerView,当有多个pickerView的时候就很消耗内存
        setUpPickerClosure = {() -> PickerView in
            
            return PickerView.singleColPicker(toolBarTitle, singleColData: data, defaultIndex: defaultSelectedIndex, cancelAction: {[unowned self] in
                
                    self.endEditing(true)
                
                }, doneAction: {[unowned self] (selectedIndex: Int, selectedValue: String) -> Void in
                    
                    doneAction?(self, selectedIndex, selectedValue)
                    self.endEditing(true)
                    
                })

            
        }
        
    }
    
    /// 多列不关联选择器
    /// - Parameter toolBarTitle: 标题
    /// - Parameter data: 数据
    /// - Parameter defaultSelectedIndexs: 默认选中的每一列的行数
    /// - Parameter autoSetSelectedText: 设置为true的时候, 将俺默认的格式自动设置textField的值
    /// - Parameter doneAction: 响应完成的Closure
    public func showMultipleColsPicker(_ toolBarTitle: String, data: [[String]], defaultSelectedIndexs: [Int]?, autoSetSelectedText: Bool, doneAction: MultipleDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in

            return PickerView.multipleCosPicker(toolBarTitle, multipleColsData: data, defaultSelectedIndexs: defaultSelectedIndexs, cancelAction: { [unowned self] in
                
                    self.endEditing(true)
                
                }, doneAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    doneAction?(self, selectedIndexs, selectedValues)
                    self.endEditing(true)
                })
        }
        
    }
    
    /// 多列关联选择器
    /// - Parameter toolBarTitle: 标题
    /// - Parameter data: 数据
    /// - Parameter defaultSelectedValues: 默认选中的每一列的行数
    /// - Parameter autoSetSelectedText: 设置为true的时候, 将按默认的格式自动设置textField的值
    /// - Parameter doneAction: 响应完成的Closure
    public func showMultipleAssociatedColsPicker(_ toolBarTitle: String, data: MultipleAssociatedDataType, defaultSelectedValues: [String]?,autoSetSelectedText: Bool, doneAction: MultipleDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in
            
           return PickerView.multipleAssociatedCosPicker(toolBarTitle, multipleAssociatedColsData: data, defaultSelectedValues: defaultSelectedValues,cancelAction: { [unowned self] in
                
                    self.endEditing(true)
                
            }, doneAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                
                doneAction?(self, selectedIndexs, selectedValues)
                self.endEditing(true)
            })
        }

    }
    
    /// 城市选择器
    /// - Parameter toolBarTitle: 标题
    /// - Parameter defaultSelectedValues: 默认选中的每一列的值, 注意不是行数
    /// - Parameter autoSetSelectedText: 设置为true的时候, 将按默认的格式自动设置textField的值
    /// - Parameter doneAction: 响应完成的Closure
    public func showCitiesPicker(_ toolBarTitle: String, defaultSelectedValues: [String]?,autoSetSelectedText: Bool, doneAction: MultipleDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in
            return PickerView.citiesPicker(toolBarTitle, defaultSelectedValues: defaultSelectedValues, cancelAction: { [unowned self] in
                    self.endEditing(true)
                
                }, doneAction:{[unowned self] (selectedIndexs: [Int], selectedValues: [String]) -> Void in
                    
                    doneAction?(self,selectedIndexs, selectedValues)
                    self.endEditing(true)
                })
        }
    
    }
    
    /// 日期选择器
    /// - Parameter toolBarTitle: 标题
    /// - Parameter datePickerSetting: 可配置UIDatePicker的样式
    /// - Parameter autoSetSelectedText: 设置为true的时候, 将按默认的格式自动设置textField的值
    /// - Parameter doneAction: 响应完成的Closure
    public func showDatePicker(_ toolBarTitle: String, datePickerSetting: DatePickerSetting = DatePickerSetting(), autoSetSelectedText: Bool, doneAction: DateDoneAction?) {
        self.autoSetSelectedText = autoSetSelectedText

        setUpPickerClosure = {() -> PickerView in
           return PickerView.datePicker(toolBarTitle, datePickerSetting: datePickerSetting, cancelAction: { [unowned self] in
                    self.endEditing(true)
                
                }, doneAction: {[unowned self]  (selectedDate) in
                    doneAction?(self, selectedDate)
                    self.endEditing(true)

            })

        }
    }
    
}


// MARK: - PickerViewDelegate -- 如果设置了autoSetSelectedText为true 这些代理方法中将以默认的格式自动设置textField的值
extension SelectionTextField: PickerViewDelegate {
    public func singleColDidSelecte(_ selectedIndex: Int, selectedValue: String) {
        if autoSetSelectedText {
            text = " " + selectedValue
        }
    }
    
    public func multipleColsDidSelecte(_ selectedIndexs: [Int], selectedValues: [String]) {
        
        
        if autoSetSelectedText {
            text = selectedValues.reduce("", { (result, selectedValue) -> String in
                 result + " " + selectedValue
            })
        }
    }
    
    public func dateDidSelecte(_ selectedDate: Date) {
        if autoSetSelectedText {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let string = formatter.string(from: selectedDate)
            text = " " + string
        }
    }
}

#endif
