//
//  BaseModel.swift
//  部分Code參考 StackOverflow : https://stackoverflow.com/questions/24310324/deserialize-json-nsdictionary-to-swift-objects/25252278
//

import Foundation

class BaseModel : NSObject {
    
    
    private var jsonStr:String?;
    private var jsonObj:[String:AnyObject]?;
    
    required init(str:String?,obj:[String:AnyObject]?) {
        self.jsonStr = str;
        self.jsonObj = obj;
    }

    public func SetJsonClassInit_FromStr(){
        if let jsonData = jsonStr?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: AnyObject]
                for (key, value) in json {
                    let keyName = key as String
                    let keyValue: String = value as! String
                    
                    if (self.responds(to: NSSelectorFromString(keyName))) {
                        self.setValue(keyValue, forKey: keyName)
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        else
        {
            print("json is of wrong format!")
        }
    }
    
    public func SetJsonClassInit_FromObj(){
        
        for (key, value) in jsonObj! {
            let keyName = key as String
            let keyValue: String = value as! String
			
            if (self.responds(to: NSSelectorFromString(keyName))) {
                self.setValue(keyValue, forKey: keyName)
            }
        }
    }
}
