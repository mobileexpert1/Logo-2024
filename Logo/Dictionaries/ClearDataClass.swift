//
//  ClearDataClass.swift
//  Logo
//
//  Created by Mobile on 01/11/22.
//

import Foundation
import UIKit
class ClearDataClass:NSObject{
     
class func removeAllValues(){
        //--FOR Removeing Values from foarm ANSWERS
    var orignal_Dictioneries = [generalDic,pipeDic,fdcDic,headsDic,wetpipeDic,drypipeDic,tanksDic,foamDic,standpipeDic,pumpDic,FlowTestDic,whilePumpIsRunningDic,checkListDic,transferSwitchDic,extinguishersDic,fireHydrantDic]
    var currentDictTag = -1
        
    SingleTon.shared.inspectReportType = nil
        for dict in orignal_Dictioneries{
            currentDictTag += 1
            for index in dict.indices{
                orignal_Dictioneries[currentDictTag][index].updateValue("", forKey: "textFieldText")
                   orignal_Dictioneries[currentDictTag][index].updateValue("", forKey: "textViewText")
                    orignal_Dictioneries[currentDictTag][index].updateValue("radio-off-button", forKey: "yesBtn")
                    orignal_Dictioneries[currentDictTag][index].updateValue("radio-off-button", forKey: "noBtn")
                    orignal_Dictioneries[currentDictTag][index].updateValue("radio-off-button", forKey: "nilBtn")
                    orignal_Dictioneries[currentDictTag][index].updateValue([String](), forKey: "pickerSelections")
                    orignal_Dictioneries[currentDictTag][index].updateValue(UIImage(), forKey: "uploadImg")
                                                                            
                                                                            }
                        }
            
        generalDic = orignal_Dictioneries[0];
        pipeDic = orignal_Dictioneries[1];
        fdcDic = orignal_Dictioneries[2];
        headsDic = orignal_Dictioneries[3];
        wetpipeDic = orignal_Dictioneries[4];
        drypipeDic = orignal_Dictioneries[5];
        tanksDic = orignal_Dictioneries[6];
        foamDic = orignal_Dictioneries[7];
        standpipeDic = orignal_Dictioneries[8];
        pumpDic = orignal_Dictioneries[9];
        FlowTestDic = orignal_Dictioneries[10];
        whilePumpIsRunningDic = orignal_Dictioneries[11];
        checkListDic = orignal_Dictioneries[12];
        transferSwitchDic = orignal_Dictioneries[13];
        extinguishersDic = orignal_Dictioneries[14];
        fireHydrantDic = orignal_Dictioneries[15];
       
    }
    
    
    
    
}
