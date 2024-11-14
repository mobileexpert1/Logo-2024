//
//  File.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 10/03/22.
//

import Foundation
import UIKit
var pickedImage = UIImage()






var titleArr1 = ["Pipe,Hangers & Values","Fire Department Connection","Sprinkler Heads","Wet Pipe","Dry Pipe","Tanks","Foam","Standpipe","Pump","Flow Test","While Pump ls Running","Check List","Transfer Switch","Extinguishers","Fire Hydrants",""]
//MARK: - Mark New Impliment 28 Oct (Ak)

var titleArr:[String] = ["Pipe,Hangers & Values","General","Fire Department Connection","Sprinkler Heads","Wet Pipe","Dry Pipe","Tanks","Foam","Standpipe","Pump","Flow Test","While Pump ls Running","Check List","Transfer Switch","Extinguishers","Fire Hydrants"]

var titleArrOrignal:[String] = ["General","Pipe","Fdc","Heads","Wetpipe","Drypipe","Tanks","Foam","Standpipe","Pump","FlowTest","WhilePumplsRunning","CheckList","TransferSwitch","Extinguishers","Fire Hydrants"]




var generalDic:[[String : Any]] = [
    ["text":"Intro photo",
          "type":"image-upload",
     "options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    
    ["text":"Visual inspection of entire system",
     "type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Have there been any modifications to the system since the last inspection?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"All systems are in service at time of inspection.","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Are all areas accessible for inspection?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"All water filled piping is located in heated areas.","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Control valves are sealed in the open position.",
     "type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Control valves are monitored by tamper switches.",
     "type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Is the building occupied?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Is occupancy the same has last inspection?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Are all new building changes and additions protected?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Are alarm systems in service?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Has monitoring company been notified?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Name of alarm company","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Password if available","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Phone number of alarm company","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
], ["text":"Any fires reported since last inspection?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Is hydraulic calc card in place?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Are system identification signs in place?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Are gauges in good working condition?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Year of gauges","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Heat tape in good working condition?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
], ["text":"Is condition of valve room in good condition?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Is system a hydraulic calculated system?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Is system a pipe schedule system?","type":"ynan","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
]]


var pipeDic:[[String : Any]] = [
    ["text":"No indication of serious corrosion?",
     "type":"ynan",
     "options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":" Non-system materials or equipment are not supported from sprinkler piping?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Hangers are secured to piping and the building structure?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Sway bracing in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Sway bracing attached to pipe and to structure satisfactory?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Are conditions of sprinkler pipe satisfactory","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Type of pipe","type":"select","options":["Black", "Galvanized", "Cpvc", "Poly", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Are conditions of control valves satisfactory?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Type of control valves","type":"select","options":["Water valve", "G x G butterfly", "OSY valve", "Gate valve", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
   /* ["text":"Gate valve Are conditions of drain valves satisfactory?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],*/
    ["text":"Are conditions of strainers satisfactory?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Are check valves in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Piping free of leaks and corrosion?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Piping through floors and walls have correct clearance?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],

["text":"Rated rpm","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Supply form","type":"select","options":["Select", "City Water", "Well Water", "Storage Tank", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Driver","type":"select","options":["Desiel", "Combustion engine", "Stream turbine drive", "Electric", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Driver Manufacturer","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Driver serial number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Driver model number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Driver rated house power","type":"select","options":["0", "5", "10", "15", "20","25","30","35","40","45","50","55","60","65","70","75"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Driver rated speed","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"If electric motor.Driver rated voltage","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Rated amps","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Phase cycle","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Controller:manufacturer","type":"select","options":["Firetrol", "Metron", "Sylvania", "G E", "Hubble","Torntech","Joslyn Clark","Eaton Culter Hammer","Master Controls","other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Controller serail number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Controller Label",
      "type":"image-upload",
 "options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
["text":"Jockey pump on system","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Jockey pump settings on pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Off pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Jockey Label",
      "type":"image-upload",
 "options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
]




var fdcDic:[[String : Any]] = [["text":"FDC is accessible & unobstructed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Inlets are not obstructed by foreign material?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Plugs or caps are in place?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Swivel connections turn freely?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Is ball drip functioning satisfactory?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Is check valve holding tight?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Are FDCs in good condition and properly maintained?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"FDC gaskets in place and in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"FDC name plate visible?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Note location of FDC","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                               ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]]


var headsDic:[[String : Any]] = [ ["text":"Sprinklers are visually free of corrosion, paint or foreign materials?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Sprinklers are less than 50 years old?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Residential & quick response sprinklers are less than 20 years old?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Sprinklers are of proper temperature rating?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"The stock of spare sprinklers is of adequate number and type?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Make of sprinklers","type":"select","options":["Viking", "Tyco", "Central", "Reliable", "Globe", "Asco", "Victaulic", "Rasco", "Gem", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Temperature of sprinklers.","type":"select","options":["135 - 170", "175 - 225", "250 - 300", "325 - 375", "400 - 475", "500 - 575", "650", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Model of sprinklers.","type":"select","options":["ssu", "ssp", "semi recessed", "concealed", "side wall", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Year of sprinklers","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Approximately number of sprinklers.","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Finish of sprinklers.","type":"select","options":["white", "chrome", "black", "brass", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Finish of escutcheons","type":"select","options":["white", "chrome", "black", "brass", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Spare head wrench available?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Sprinkler spray patterns are not obstructed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"All protected areas have adequate sprinkler coverage?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Dry pendent sprinklers older than 10 years replaced?","type":"ynan","options":["Y", "NA", "N"],"textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Make of dry pendant","type":"select","options":["Viking", "Tyco", "Central", "Reliable", "Globe", "Asco", "Victaulic", "Rasco", "Gem", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Model of dry pendant","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Year of dry pendant","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Approximate number of dry pendant","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Finish of dry pendant","type":"select","options":["white", "chrome", "black", "brass", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Sprinklers are not subject to recall?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Sprinklers with glass bulbs look to be full of liquid?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Are all required sprinkler tests up to date?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
]

var wetpipeDic:[[String : Any]] = [["text":"Alarm valves in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Retard chamber in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"All flow indicators in good working condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Record time for flow switch in seconds","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Were all sectional/floor control valves inspected?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Number of valves","type":"text-input","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Were all sectional/floor flow switches inspected?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                  /* ["text":"Flow switch average times in seconds","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],*/
["text":"Flow switch average times in seconds","type":"text-input","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Are all other valves in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Are cold weather valves open or closed as needed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Antifreeze systems satisfactorily tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Type of Antifreeze solution","type":"select","options":["Propylene glycol", "Glycerin", "Ethylene glycol", "alcohol", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Antifreeze solution tested @ [degrees]","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"at what percent","type":"text-input","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Approximate volume","type":"text-input","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Are valve room heaters operating properly?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Backflow tested as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Forward flow test performed as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Are valve rooms accessible with adequate clearance?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Was a main drain test performed with satisfactory results?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Static pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Residual pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Size of main drain","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Main drain fully open and flow observed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"If no main drain test was performed state explanation","type":"text-input","options":[""],"uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Gauges replaced or calibrated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Are all other valves open or closed as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Alarm valve identification","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Make of alarm valve","type":"select","options":["Viking", "Tyco", "Central", "Reliable", "Globe", "Asco", "Victaulic", "Rasco", "Gem", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Model of alarm valve","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Size of alarm valve","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Year of alarm valve","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Has internal investigation been performed in last 5 years?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Date of last inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Alarm panel reset and clear of alarms?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Was system tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"If Tagged what color","type":"select","options":["Red", "Green", "white"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]]


var drypipeDic:[[String : Any]] = [["text":"Type of system","type":"select","options":["Dry valve", "Preaction valve", "Preaction Dual interlock", "Preaction Single interlock", "Preaction Pneumatic release", "Deluge valve", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Dry valve in service and in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Dry valve identification","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Make of dry valve","type":"select","options":["Viking", "Tyco", "Central", "Reliable", "Globe", "Asco", "Victaulic", "Rasco", "Gem", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Model of dry valve","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Size of dry valve in inches","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Year of dry valve","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()] ,
                                   ["text":"Main drain test performed with satisfactory results?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Static pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Residual pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Gauges replaced or calibrated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Air pressure set at correct level?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Cut off pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Cut in pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Low air pressure switch activates at","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Date of last trip test","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Dry valve successfully trip tested and returned to service?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Dry valve in service and in good condition ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Model of dry valve","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Pressures before testing air #","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Dry valve identification","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Water #","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Control valve fully open?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Operated @ air pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Time it took to trip [seconds]","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Time for water to reach inspectors test [seconds]","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Interior of dry valve was satisfactory including all moving parts?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Trip test performed without repairs?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Did alarms work during test?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Quick opening devices operate properly and reset?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Make of quick opening device","type":"select","options":["Viking", "Tyco", "Central", "Reliable", "Globe", "Asco", "Victaulic", "Rasco", "Gem", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Model of quick opening device","type":"text-input","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Year of quick opening device","type":"text-input","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Condition of quick opening device","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Valve reset dry?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"All supervisory devices successfully tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"All automatic release devices tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Manual release devices tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Quick-opening devices successfully tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Priming water level is normal?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"All low points drained at fall inspection?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Number of auxiliary drains","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Has an assessment of the internal condition of piping been performed during the past 5 years","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Date of last inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Has piping been checked for proper slope in the last 10 years?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Date of last inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Is valve room adequately heated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Are all other valves in their proper position?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Alarm panels reset and clear of alarms?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Was System Tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Tag color?","type":"select","options":["Red", "Green", "White"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]

]

var tanksDic:[[String : Any]] = [["text":"Water temperature- low temperature alarms tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Heating system tested and in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                   ["text":"Tank fill valve in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Control valves in normal position?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Water level alarms tested?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Air pressure in tank normal?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Condition of exterior of tank satisfactory?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Tank support structure appears to be in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Catwalks and ladders in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Interior of tank in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Area around tank in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"3 year inspections completed as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Date of last inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"5 year inspections completed as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Date of last inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Was System Tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"If Tagged Tag Color","type":"select","options":["Red", "Green", "White"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
                                 
                                   

]

var foamDic:[[String : Any]] = [ ["text":"Discharge device location (Sprinkler)","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Discharge device location (Spray nozzle)","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Discharge device position (Sprinkler)","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Discharge device position (Spray nozzle)","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Foam concentrate strainers inspected as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Proportioning systems inspected as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Pipe corrosion investigated as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Pipe system in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Storage tanks for foam supply in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Capacity of tank","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Type of foam used in system","type":"select","options":["AFFF", "Protein-foam", "Flouro-protien foam", "Film-forming foam", "Alchohol-resistant foam", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Number of tanks in system","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Foam concentrate tested and in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Actuation devices tested and in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Detection devices tested as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"5 year maintenance completed as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Date of last 5 year maintenance","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"10 year maintenance completed as required","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Date of last 10 year maintenance","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Was System Tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"If Tagged what color","type":"select","options":["Red", "Green", "White"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                 ["text":"Foam comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]

]


var standpipeDic:[[String : Any]] = [
    ["text":"Visual inspection of entire system?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"There have been no modifications since the last inspection?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"All systems are in service?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Control valves are in the open position?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Control valves are locked open or have tamper switches?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"No indication of serious corrosion?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Hangers and supports are secured to pipe and building structure?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"FDC is accessible and unobstructed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"FDC inlets are not obstructed by foreign material?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"FDC plugs and caps are in place?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"FDC swivel connections turn freely?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Hose valves are operable and have caps?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Are hoses in service as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Hose in racks have been tested in last 5 years and have adjustable nozzles?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Date of last test","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Number of hose racks","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Standpipe classification.","type":"select","options":["Dry standpipe", "Class I standpipe", "Class II standpipe", "Class III standpipe", "Manual standpipe", "Wet standpipe", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Was 5 year flow test performed as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Date of last flow test inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Was 5 year hydrostatic test performed as required","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Date of last hydrostatic test inspection","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Was system tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"If tagged, what color?","type":"select","options":["Red", "Green", "White"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]

]


var pumpDic:[[String : Any]] = [
    ["text":"Add this section to report","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Type of pump","type":"select","options":["horizontal", "split case", "vertical in line", "vertical shaft", "temuri", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Pump Manufacturer","type":"select","options":["DD peerless", "Aurora", "Waterous", "SPP", "AC Fire Pump", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Serial number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Model number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Pump Label","type":"image-upload","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Rated volume","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Rated pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Rated rpm","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Supply from","type":"select","options":["city water", "well water", "storage tank", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver","type":"select","options":["Diesel", "Combustion engine", "Steam turbine drive", "Electric", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver Manufacturer","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver Serial number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver Model number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver Rated house power","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver Rated speed","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"If electric motor: Driver rated voltage","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver Operating voltage","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Rated amps","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Phase cycles","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Controller: manufacturer","type":"select","options":["Firetrol", "Metron Sylvania GE", "Hubble", "Torntech", "Joslyn Clark", "Eaton Cutler Hammer", "Master Controls", "other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Controller Serial number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Model number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Controller Label","type":"image-upload","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Jockey pump on system?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"JOCKEY PUMP settings: on pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Off pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Jockey Label","type":"image-upload","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
    
    
]


var FlowTestDic:[[String : Any]] = [["text":"Flow Test Table","type":"flow-test-table","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"For electric driven fire pump record voltage and amps","type":"electric-driven-table","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Flow test completed with the use of # of pitot tubes","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Flow Meter is functional","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Pitot pressure used to measure flow","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Main drain test static","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Residual presure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Time for supply to reach normal pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Adequate drainage provided before flow testing?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Pump suction and discharge pressures and flow measurements at each hose stream used to determine total pump output where hose streams used in testing?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Care taken to prevent water damage by verifying adequate drainage?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Flow test conducted under minimum, rated and peak fire pump flows?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Flow test conducted by controlling quantity of water discharged through test devices?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Fire pump operated at maximum allowable discharge?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Fire pump suction supply provided required flow at 0 pressure or higher gauge pressure at pump suction flange?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Electric fire pump driver did not overload beyond rating while delivering necessary brake horsepower?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Pump suction and discharge pressures and flow- meter measurements used to determine total pump output where flow meter used in testing?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Flow meter adjusted immediately prior to testing in accordance with mfg. instructions?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Test results using flow meter consistent with previous annual test results (IF no, complete flow test using hose streams OR calibrate flow meter)","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                    ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
                                    
                                    
    
]

var whilePumpIsRunningDic:[[String : Any]] = [["text":"At churn, circulation relief valve checked for operation and water discharge?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"At churn, pressure relief valve checked for proper operation?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"At churn, pressure control valve checked for proper operation?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"At churn, test continued for minimum of [Minutes]","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"At each flow condition, electric motor voltage and current in all lines recorded?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"At each flow condition, pump speed recorded?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"At each flow condition, simultaneous readings of pump suction and discharge pressures and pump discharge flow recorded?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Pressure relief valve closely observed during each flow condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Pressure control valve closely observed during each flow condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Pressure relief valve functioning properly?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Pressure control valve functioning properly?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Pressure relief valve closed by pilot adjustment during flow conditions?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Pressure relief valve reset to normal position at pump test conclusion?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                              ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]

]

var checkListDic:[[String : Any]] = [["text":"System in service on arrival?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Responsible parties notified before testing?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Alarm company notified before testing?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Control valves in normally open or normally closed position?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Control valves properly locked or supervised?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Control valve supervisory switches initiate signal properly?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Signal restored only when valve returned to normal position?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Operating stems of OS&Y valves lubricated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Control valves operated through full range and returned to normal position?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Control valves are free from external leaks?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Control valve identification signs in place?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Battery systems in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Battery system charger and charge rate operational, normal and equalized?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Circuit breakers or fuses checked?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Isolating switch exercised?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Circuit breakers exercised?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"crankcase breather inspected and in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Engine exhaust system inspected and in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electrical wiring subject to movement free from chafing?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Strainer, filter or dirt leg (or combination thereof) cleaned?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Crankcase breather cleaned or changed (as necessary)?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Water strainer cleaned?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Manual starting means of electrically driven pumps operated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Antifreeze protection level tested and adjusted as necessary?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electrical system safety devices and alarms operated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electrical system boxes, panels and cabinets cleaned?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Hangers and seismic bracing appear undamaged and tightly attached?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Piping appears free of mechanical damage and in satisfactory condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Building is secure such as not to expose piping to freezing conditions?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Adequate heat is provided maintaining temp at 40°F / 4.4°C or higher?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Pump shaft end play with specified tolerances?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Pressure gauge and sensor accuracy verified to be within 5%?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Pump coupling alignment within specified tolerances?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electrical connections tightened as necessary?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Mechanical moving parts lubrication verified?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Pressure switch setting calibration verified?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Fuel tank vents and overflow piping free from obstructions?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Fuel piping in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Combustion air ductwork and louvers in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electrical control and power wiring connections checked for tightness?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"pump bearing lubricated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Gauges recalibrated or changed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Wet pit suction screens checked (cleaned as necessary) after every operation?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Mechanical transmission coupling lubricated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Mechanical transmission right-angle gear drive lubricated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electric drive motor bearings lubricated?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Diesel engine maintenance schedule up to date as required?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Diesel engine cooling system antifreeze checked?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Electrical system circuit breakers or fuses changed (every 2 years)?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                     ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
                                     

]

var transferSwitchDic:[[String : Any]] = [["text":"Power failure condition simulated while pump operating at peak load?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Transfer switch transfer of power to alternate power source verified?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Pump maintenance of peak load performance verified?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Power failure condition removed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Pump reconnected to normal power source after a time delay?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Was system tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"If tagged what color?","type":"select","options":["red", "green", "white"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                          ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
    
]


var extinguishersDic:[[String : Any]] = [["text":"Total number of extinguishers inspected.","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all extinguishers visible?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all extinguishers accessible?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all extinguishers in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are extinguisher cabinets in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all pressure gauges and pull pins in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all extinguishers of the proper class?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Do extinguishers cover the proper square footage for the hazard protected?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all extinguisher labels in place?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Have all maintenance intervals been performed?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Date of last maintenance interval","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"6 year maintenance","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"12 year hydro test","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"5 year hydro test","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Other","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Are all hoses and nozzles in good condition?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Was system tagged?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
                                         

]

//MARK: - New Impliment on 28 Oct (AK)

var fireHydrantDic:[[String : Any]] = [["text":"Year","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       ["text":"Location","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       ["text":"Date","type":"text-date","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       
                                         ["text":"There are no leaks in the hydrant ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       
                                         ["text":"Operating nut is not worn and does not have rounded corners ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       ["text":"System","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       
                                       
                                       
                                         ["text":"Hydrant outlets are slightly more than hand-tight ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       
                                         ["text":"There are no cracks in the hydrant barrel ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       
                                       
                                       
                                       
                                         ["text":"Nozzels threads are not damaged ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                       ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
                                         ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]
                                         

]


var pipeHangersValueSectionDic:[[String : Any]] = [
    ["text":"No Indiacation of serious corrosion?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Hangers are secured to piping and the building structure ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Sway bracing attached to pipe and to structure satisfactory ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Are conditions of sprinkler pipe satisfactory ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
["text":"Rated rpm","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Driver","type":"select","options":["Deisel", "Combustion engine", "Stream Turbine drive", "Electric", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
["text":"Driver serial number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
   
    ["text":"Driver rated house power","type":"select","options":["5","10","15","20","25","30","35","40","45","50","55","60","65","70","75"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],

    ["text":"If electric motor.Driver rated voltage","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Phase cycle","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":" Controller serail number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
   
    ["text":"Jockey pump on system","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
["text":" Off pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    
    ["text":"Non-system materials or equipment are not supported from sprinkler piping ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Sway bracing in good condition ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Are conditions of sprinkler pipe satisfactory ?","type":"ynan","options":["Y", "NA", "N"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Type of pipe","type":"select","options":["Black", "Galvanized", "Cpvc", "Poly", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Supply form","type":"select","options":["City Water", "Well Water", "Stoage Tank", "Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Driver Manufacturer","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver model number","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Driver rated speed","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Rated amps","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    
    ["text":"Controller:manufacturer","type":"select","options":["Firetrol","Metron","Sylvania","G E","Hubble","TornTech","Joslyn Clark","Eaton Culter Hammer","Master Controls","Other"],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Controller Label",
          "type":"image-upload",
     "options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Jockey pump settings on pressure","type":"text-input","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],

    ["text":"Jockey Label",
          "type":"image-upload",
     "options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()
],
    ["text":"Deficiencies","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()],
    ["text":"Inspector comments","type":"text-box","options":[""],"textFieldText":"","textViewText":"","yesBtn":"radio-off-button","noBtn":"radio-off-button","nilBtn":"radio-off-button","uploadImg":UIImage(),"pickerSelections":[String]()]

]


//                           ["text":"","type":"ynan","options":["Y", "NA", "N"]]


//                             ["text":"","type":"select","options":[""]]


//                                ["text":"","type":"text-input","options":[""]]


//                                ["text":"","type":"text-box","options":[""]]


//                                   ["text":"","type":"input-date","options":[""]]

//                         ["text":"","type":"flow-test-table","options":[""]]

//                            ["text":"","type":"electric-driven-table","options":[""]]

//                         ["text":"","type":"image-upload","options":[""]]


var conditionsScope = """
• SCOPE OF WORK
• Contractor shall inspect and or test the equipment described herein in accordance the contract option selected above and the Contractors then current Report Form. All in accordance with terms and conditions contained herein and on the reverse side hereof.

• TERM

• The term of this agreement shall be one (I) year from date hereof and shall be automatically renewed each year thereafter until the same shall be terminated by either party on at least 'thirty (30) days Written notice being given to the other party prior to the anniversary date thereof. Contractors then current charges shall apply for each renewal period.
"""

var conditionsScope2 = """
• Cost of Inspection
The subscriber shall pay to Contractor within 30 days after the first inspection has been made. If subscriber fails to pay the full amount due, Contractor, may at its option, terminate this contract, and, in any event, will not be obligated to perform any additional work until payment of the amount past due has been received by contractor.

• Report of Inspection
Notice of this agreement and copies of all Reports of inspection and or will be forward by the Contractor to authority having jurisdiction, where required, and to the Subscriber. Notice of termination shall be reported to authority having jurisdiction by Contractor.

• LIMITATION OF LIABILITY
The Contractor makes: N0 WARRANTIES, EXPRESS, OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES OF MERCHANTABILITY AND WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE. No promise not contained herein or affirmation of fact made by any employee, agent or representative of the Contractor shall constitute a Warranty by the Seller or give rise to any liability or obligation.
Contractors liability to Subscriber for personal injury, death, or property damage arising from performance under this contract shall be limited to the contract price. Subscriber shall hold Contractor harmless from any and all third party claims for personal injury, death or property damage, arising from Subscribers failure to maintain these systems or keep them in operative condition, whether based upon contract, warranty, tort, strict liability or otherwise. In no event shall the Contractor be liable for any special, indirect, incidental, consequential or liquidated, penal or any economic loss damages of any character, including but not limited to loss of use of Subscribers property, lost profits or lost production, whether claimed by the Subscriber or by any third party, irrespective of whether claims or actions for such damages are based upon contract, warranty, negligence, tort, strict liability or otherwise.

• TERMS AND CONDITIONS

• REPORTS
The inspection and or test shall be completed on the Contractors then current Report form, which shall be given to the Subscriber. The report and recommendations by the Contractor are only advisory in nature and are intended to assist Subscriber in reducing the possibility of loss of property by indicating obvious defects or impairments noted to the system and equipment inspected and or tested which require prompt consideration. They are not intended to imply that all other defects, hazards or aspects of the system and equipment are under control at the time of inspection. Final responsibility for the condition and operation of the sprinkler system and or fire alarm and detection system equipment lies with the Subscriber.

• EMERGENCY SERVICE
Emergency service requested by the Subscriber will be furnished at an extra charge.
"""

var conditionsScope34 = """
   Emergency/Service Rates:
   
   Straight Time (M-F 7:30AM-3:30PM):
   4-hour minimum each Technician
   $120 per hour each
   Total: $960 (2T)
   $85 flat rate for travel + material + tax
   Anything over 4 hours is additional
   
   Over Time (M-F 3:31PM - 7:29AM):
   4-hour minimum each Technician
   $180 per hour each
   Total: $1,440.00 (2T)
   $85 flat rate for travel + material + tax
   Anything over 4 hours is additional
   
   Saturday (12:00AM - 11:59PM):
   4-hour minimum each Technician
   $180 per hour each
   Total: $1,440.00 (2T)
   $85 flat rate for travel + material + tax
   Anything over 4 hours is additional
   
   Double Time (Sunday 12:01AM-11:59 PM):
   4-hour minimum each Technician
   $240 per hour each
   Total: $1,920.00 (2T)
   $85 flat rate for travel, + material, + tax
   Anything over 4 hours is additional
   
   Notes:
   Emergency calls/inspections fall under overtime rates and must be COD.
   Any inspections or service/emergency calls attended but unable to gain access will incur a travel charge.
   Any changes or modifications to the work scope may result in adjustments to labor and material changes.
   In accordance with industry standards and for optimal safety and efficiency, our services consistently necessitate the presence of two technicians, ensuring thorough and precise execution under varying conditions.
   """

var conditionsScope3 = """
• ADDITIONAL EQUIPMENT
In the event additional equipment is installed after the date of this contract, the annual inspection charge shall be increased in accordance with contractors prevailing rates as of the first inspection of such additional equipment.

• WORK NOT INCLUDED
The inspection and testing provided under this agreement does not include any maintenance, repairs, alterations and replacement of parts or any field adjustments whatsoever.
Should any such work be requested by Subscriber they will be as an addition to this agreement. The contractor shall furnish the Subscriber with an estimate price before the additional work.

• ACCEPTANCE OF TERMS
No changes or modifications are to be made without the written consent of executive officer of the contracting firm. Contractor is not bound by any provisions printed or otherwise at variance with this agreement that may appear on any acknowledgment or other form used by Subscriber, such provisions being hereby expressly rejected.

• ENTRY
Contractor may enter Subscribers premises at all reasonable times to perform the inspections required by this contract.

• ASSIGNMENT
This contract shall constitute a personal agreement between Contractor and Subscriber and shall be assignable by either party only with a written consent of the other.
"""
var conditions = """
• SCOPE OF WORK
• Contractor shall inspect and or test the equipment described herein in accordance the contract option selected above and the Contractors then current Report Form. All in accordance with terms and conditions contained herein and on the reverse side hereof.

• TERM

• The term of this agreement shall be one (I) year from date hereof and shall be automatically renewed each year thereafter until the same shall be terminated by either party on at least 'thirty (30) days Written notice being given to the other party prior to the anniversary date thereof. Contractors then current charges shall apply for each renewal period.

• Cost of Inspection

• The subscriber shall pay to Contractor within 30 days after the first inspection has been made. If subscriber fails to pay the full amount due, Contractor, may at its option, terminate this contract, and, in any event, will not be obligated to perform any additional work until payment of the amount past due has been received by contractor.

• Report of Inspection

• Notice of this agreement and copies of all Reports of inspection and or will be forward by the Contractor to authority having jurisdiction, where required, and to the Subscriber. Notice of termination shall be reported to authority having jurisdiction by Contractor.

• LIMITATION OF LIABILITY

• The Contractor makes: N0 WARRANTIES, EXPRESS, OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES OF MERCHANTABILITY AND WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE. No promise not contained herein or affirmation of fact made by any employee, agent or representative of the Contractor shall constitute a Warranty by the Seller or give rise to any liability or obligation.

• Contractors liability to Subscriber for personal injury, death, or property damage arising from performance under this contract shall be limited to the contract price. Subscriber shall hold Contractor harmless from any and all third party claims for personal injury, death or property damage, arising from Subscribers failure to maintain these systems or keep them in operative condition, whether based upon contract, warranty, tort, strict liability or otherwise. In no event shall the Contractor be liable for any special, indirect, incidental, consequential or liquidated, penal or any economic loss damages of any character, including but not limited to loss of use of Subscribers property, lost profits or lost production, whether claimed by the Subscriber or by any third party, irrespective of whether claims or actions for such damages are based upon contract, warranty, negligence, tort, strict liability or otherwise.

• TERMS AND CONDITIONS

• REPORTS

• The inspection and or test shall be completed on the Contractors then current Report form, which shall be given to the Subscriber. The report and recommendations by the Contractor are only advisory in nature and are intended to assist Subscriber in reducing the possibility of loss of property by indicating obvious defects or impairments noted to the system and equipment inspected and or tested which require prompt consideration. They are not intended to imply that all other defects, hazards or aspects of the system and equipment are under control at the time of inspection. Final responsibility for the condition and operation of the sprinkler system and or fire alarm and detection system equipment lies with the Subscriber.

• EMERGENCY SERVICE

• Emergency service requested by the Subscriber will be furnished at an extra charge.

• ADDITIONAL EQUIPMENT

• In the event additional equipment is installed after the date of this contract, the annual inspection charge shall be increased in accordance with contractors prevailing rates as of the first inspection of such additional equipment.

• WORK NOT INCLUDED

• The inspection and testing provided under this agreement does not include any maintenance, repairs, alterations and replacement of parts or any field adjustments whatsoever.

• Should any such work be requested by Subscriber they will be as an addition to this agreement. The contractor shall furnish the Subscriber with an estimate price before the additional work.

• ACCEPTANCE OF TERMS

• No changes or modifications are to be made without the written consent of executive officer of the contracting firm. Contractor is not bound by any provisions printed or otherwise at variance with this agreement that may appear on any acknowledgment or other form used by Subscriber, such provisions being hereby expressly rejected.

• ENTRY

• Contractor may enter Subscribers premises at all reasonable times to perform the inspections required by this contract.

• ASSIGNMENT

• This contract shall constitute a personal agreement between Contractor and Subscriber and shall be assignable by either party only with a written consent of the other.


"""
var privacyCondins =

 """
Our company is committed to protecting the Client's right to privacy. All personal information obtained from the Client is solely for the purpose of the inspection assignment and billing purposes. The personal information obtained is not shared with any third party source without the expressed consent of the Client.

Our company acknowledges that the Inspection Report completed by the Inspector may contain sensitive information, which if distributed, may cause financial harm to the Client. Therefore, our company maintains a strict confidentiality policy which prohibits any unauthorized distribution of the Inspection Report or disclosure of the results of the assignment. However, the Client may authorize additional recipients of the Inspection Report by notifying the Inspector or Inspection company in writing or by providing verbal authorization.
"""

var acknowledgementsTopTxt =
" CLIENT has carefully read the foregoing, agrees to it, and acknowledges receipt of a copy of this agreement and acknowledges limitations placed upon the inspection. The CLIENT acknowledges that by signing this agreement, that the CLIENT has entered into this agreement without influence, duress or penalty. "
var acknowledgementsMidLbl =
"INSPECTOR acknowledges by signing below that he/she is acting on behalf of 24/7 Fire Protection Inc. in performance of inspection(no client signature) SIRJ NJ LLC services agreed to in the foregoing."
