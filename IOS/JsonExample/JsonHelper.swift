//
//  JsonHelper.swift
//  取得ClassType 參考於 : https://stackoverflow.com/questions/40373030/how-to-create-instance-of-a-class-from-a-string-in-swift-3
//

import Foundation

class JsonHelper
{
    public func JsonStringtoJsonObject(jsonString:String,isJsonArray:Bool,cls:String)->  AnyObject  {
        
        let myclass = stringClassFromString(cls) as! BaseModel.Type;
        
        if(isJsonArray)
        {
            let jsonData = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            let json = try? JSONSerialization.jsonObject(with: jsonData!, options: []) as! [[String: AnyObject]];
            
            var objList : [AnyObject] = [];
            
            for one in json! {
                let oneCls = myclass.init(str: nil,obj: one);
                oneCls.SetJsonClassInit_FromObj();
                objList.append( oneCls );
            }
            return objList as AnyObject;
        }
        else
        {
            let res = myclass.init(str: jsonString,obj:nil);
            res.SetJsonClassInit_FromStr();
            return res ;
        }
        
    }
    
    func stringClassFromString(_ className: String) -> AnyClass! {
        
        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        
        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
        
        // return AnyClass!
        return cls;
    }
}
