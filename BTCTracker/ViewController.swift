//
//  ViewController.swift
//  BTCTracker
//
//  Created by Kang Paul on 2018/9/1.
//  Copyright © 2018年 Kang Paul. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    @IBOutlet weak var btcPrice: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //currency abbreviations https://www.easymarkets.com/int/learn-centre/discover-trading/currency-acronyms-and-abbreviations/
    
    let currencyArray = ["USD", "TWD", "CNY", "JPY"]
    
    var btcBaseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate   = self
        currencyPicker.dataSource = self
        getBTCPrice( url: btcBaseURL + currencyArray[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBTCPrice( url: String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success!");
                
                let btcJSON: JSON = JSON(response.result.value!)
                
                let lastResult = btcJSON["last"].double!
                print(lastResult)
                self.btcPrice.text = String(lastResult)
            }
            else {
                print("Error \(response.result.error)")
                self.btcPrice.text = "Error"
            }
        }

    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let btcURL = btcBaseURL + String(currencyArray[row])
        print(btcURL)
        getBTCPrice( url: btcURL)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Arial", size: 40)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = currencyArray[row]
        pickerLabel?.textColor = UIColor.white

        return pickerLabel!
    }
        
        

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 50
    }
}

