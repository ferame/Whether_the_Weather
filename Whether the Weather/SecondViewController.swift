//
//  SecondViewController.swift
//  Whether the Weather
//
//  Created by Justinas Alisauskas on 30/01/2016.
//  Copyright © 2016 JustInCode. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userInputField: UITextField!
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        //let city: String = String(userInputField.text!)
        let wholeLink = NSURL(string: "http://www.weather-forecast.com/locations/" + userInputField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        if let url = wholeLink {
            //url variable(string)
            //webView.loadRequest(NSURLRequest(URL: url))
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                //will happen when task completes
                if let urlContent = data{
                    
                    let urlContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.resultLabel.text = self.giveForecast(urlContent!)
                        self.resultLabel.sizeToFit()
                        //self.resultLabel.backgroundColor = UIColor.whiteColor()
                        self.resultLabel.textColor = UIColor.whiteColor()
                        if !cityList.contains(String(self.userInputField.text!)){
                            cityList.append(self.userInputField.text!)
                            print("CityList appended " + String(self.userInputField.text!))
                            NSUserDefaults.standardUserDefaults().setObject(cityList, forKey: "cityList")
                        }
                    })

                }else{
                    //Show error message
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.resultLabel.text = "City not found/ Information not available"
                        self.resultLabel.sizeToFit()
                        self.resultLabel.textColor = UIColor.redColor()
                    })

                }
            }
            task.resume()
        }else{
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.resultLabel.text = "City not found/ Information not available"
                self.resultLabel.sizeToFit()
            })
            
        }
    }
    
    @IBOutlet var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInputField.delegate = self
        //resultLabel.sizeToFit()
        print("Second View Did Load")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        print("touches around the screen")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("return button touched")
        return true
    }
    
    func giveForecast(urlContent: NSString) -> String{
        var forecast: String
        if urlContent.containsString("phrase\">"){
            print("passed forecast")
            var arrayForecast = urlContent.componentsSeparatedByString("phrase\">")
            arrayForecast = arrayForecast[1].componentsSeparatedByString("</span>")
            forecast = arrayForecast[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
            
        }else{
            print("gotcha")
            forecast = "City not found/ Information not available"
        }
        return forecast
    }
}