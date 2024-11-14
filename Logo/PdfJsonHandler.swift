//  PdfJsonHandler.swift

import Foundation

class PdfJsonHandler {
    
    // Pipe,Hangers & Values
    var pipeHangerValueFormDict = [String:String]()
    var pipeHangerValueFormDictString = ""
    
    // General
    var generalFormDict = [String:String]()
    var generalFormDictString = ""
    
    // Fire Department Connection
    var fireDepartmentConnectionFormDict = [String:String]()
    var fireDepartmentConnectionFormDictString = ""
   
    // Sprinkler Heads
    var sprinklerHeadsFormDict = [String:String]()
    var sprinklerHeadsFormDictString = ""
    
    // Wet Pipe
    var wetPipeFormDict = [String:String]()
    var wetPipeFormDictString = ""
    
    // Dry Pipe
    var dryPipeFormDict = [String:String]()
    var dryPipeFormDictString = ""
     
    // Tanks
    var tanksFormDict = [String:String]()
    var tanksFormDictString = ""
    
    // Foam
    var foamFormDict = [String:String]()
    var foamFormDictString = ""
    
    // Standpipe
    var standpipeFormDict = [String:String]()
    var standpipeFormDictString = ""
    
    // Pump
    var pumpFormDict = [String:String]()
    var pumpFormDictString = ""
    
    // Flow Test
    var flowTestFormDict = [String:String]()
    var flowTestFormDictString = ""
    
    // While Pump ls Running
    var whilePumplsRunningFormDict = [String:String]()
    var whilePumplsRunningFormDictString = ""
    
    // Check List
    var checkListFormDict = [String:String]()
    var checkListFormDictString = ""
    
    // Transfer Switch
    var transferSwitchFormDict = [String:String]()
    var transferSwitchFormDictString = ""
    
    // Extinguishers
    var extinguishersFormDict = [String:String]()
    var extinguishersFormDictString = ""
    
    // Fire Hydrants
    var fireHydrantsFormDict = [String:String]()
    var fireHydrantsFormDictString = ""
    
}

// MARK: - Pipe,Hangers & Values
extension PdfJsonHandler {
    func setupPipeHangerValueFormDict() {
        pipeHangerValueFormDict["No Indiacation of serious corrosion ?"] = "Yes"
        pipeHangerValueFormDict["Non-system materials or equipment are not supported from sprinkler piping ? "] = "Yes"
        pipeHangerValueFormDict["Hangers are secured to piping and the building structure ?"] = "Yes"
        pipeHangerValueFormDict["Sway bracing in good condition ?"] = "Yes"
        pipeHangerValueFormDict["Sway bracing attached to pipe and to structure satisfactory ?"] = "Yes"
        pipeHangerValueFormDict["Are conditions of sprinkler pipe satisfactory ?"] = "Yes"
        pipeHangerValueFormDict["Type of pipe"] = "String"
        pipeHangerValueFormDict["Gate valve Are conditions of drain valves satisfactory?"] = "Yes"
        pipeHangerValueFormDict["Type of control valves"] = "String"
        pipeHangerValueFormDict["Are conditions of strainers satisfactory?"] = "Yes"
        pipeHangerValueFormDict["Are check valves in good condition?"] = "Yes"
        pipeHangerValueFormDict["Piping free of leaks and corrosion?"] = "Yes"
        pipeHangerValueFormDict["Piping through floors and walls have correct clearance?"] = "Yes"
        pipeHangerValueFormDict["Rated rpm"] = "String"
        pipeHangerValueFormDict["Supply form"] = "String"
        pipeHangerValueFormDict["Driver"] = "String"
        pipeHangerValueFormDict["Driver Manufacture"] = "String"
        pipeHangerValueFormDict["Driver serial number"] = "String"
        pipeHangerValueFormDict["Driver model number"] = "String"
        pipeHangerValueFormDict["Driver rated house power"] = "String"
        pipeHangerValueFormDict["Driver rated speed"] = "String"
        pipeHangerValueFormDict["If electric motor.Driver rated voltage"] = "String"
        pipeHangerValueFormDict["Rated amps"] = "String"
        pipeHangerValueFormDict["Phase cycle"] = "String"
        pipeHangerValueFormDict["Controller:manufacturer"] = "String"
        pipeHangerValueFormDict["Controller serail number"] = "String"
        pipeHangerValueFormDict["Controller Label"] = "base64"
        pipeHangerValueFormDict["Jockey pump on system "] = "Yes"
        pipeHangerValueFormDict["Jockey pump settings on pressure"] = "String"
        pipeHangerValueFormDict["Off pressure"] = "String"
        pipeHangerValueFormDict["Jockey Label"] = "base64"
        pipeHangerValueFormDict["Deficiency"] = "String"
        pipeHangerValueFormDict["Inspector comments"] = "String"
        pipeHangerValueFormDictString = pipeHangerValueFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(pipeHangerValueFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - General
extension PdfJsonHandler {
    func setupGeneralFormDict() {
        generalFormDict["Intro photo"] = "Yes"
        generalFormDict["Visual inspection of entire system"] = "Yes"
        generalFormDict["Have there been any modifications to the system since the last inspection? "] = "Yes"
        generalFormDict["All systems are in service at time of inspection"] = "Yes"
        generalFormDict["Are all areas accessible for inspection? "] = "Yes"
        generalFormDict["All water filled piping is located in heated areas"] = "Yes"
        generalFormDict["Control valves are sealed in the open position."] = "Yes"
        generalFormDict["Control valves are monitored by tamper switches."] = "Yes"
        generalFormDict["Is the building occupied?"] = "Yes"
        generalFormDict["Is occupancy the same has last inspection?"] = "Yes"
        generalFormDict["Are all new building changes and additions protected?"] = "Yes"
        generalFormDict["Are alarm systems in service? "] = "Yes"
        generalFormDict["Has monitoring company been Notified? "] = "Yes"
        generalFormDict["Any fires reported since last inspection?"] = "Yes"
        generalFormDict["Is hydraulic calc card in place?"] = "Yes"
        generalFormDict["Are system identification signs in place?"] = "Yes"
        generalFormDict["Are gauges in good working condition?"] = "Yes"
        generalFormDict["Year of gauges"] = "Yes"
        generalFormDict["Heat tape in good working condition?"] = "Yes"
        generalFormDict["Is condition of valve room in good condition?"] = "Yes"
        generalFormDict["Is system a hydraulic calculated system? "] = "Yes"
        generalFormDict["Is system a pipe schedule system?"] = "Yes"
        generalFormDict["Name of alarm company"] = "Yes"
        generalFormDict["Password if available"] = "Yes"
        generalFormDict["Phone number of alarm company"] = "Yes"
        generalFormDict["Deficiency"] = "Yes"
        generalFormDict["Inspector comments"] = "Yes"
     
        generalFormDictString = generalFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(generalFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Fire Department Connection
extension PdfJsonHandler {
    func setupFireDepartmentConnectionFormDict() {
        fireDepartmentConnectionFormDict["FDC is accessible & unobstructed?"] = "Yes"
        fireDepartmentConnectionFormDict["Inlets are not obstructed by foreign material?"] = "Yes"
        fireDepartmentConnectionFormDict["Plugs or caps are in place?"] = "Yes"
        fireDepartmentConnectionFormDict["Swivel connections turn freely?"] = "Yes"
        fireDepartmentConnectionFormDict["Is ball drip functioning satisfactory?"] = "Yes"
        fireDepartmentConnectionFormDict["Is check valve holding tight?"] = "Yes"
        fireDepartmentConnectionFormDict["Are FDCs in good condition and properly maintained?"] = "Yes"
        fireDepartmentConnectionFormDict["FDC gaskets in place and in good condition?"] = "Yes"
        fireDepartmentConnectionFormDict["FDC name plate visible?"] = "Yes"
        fireDepartmentConnectionFormDict["Note location of FDC"] = "Yes"
        fireDepartmentConnectionFormDict["Deficiencies"] = "Yes"
        fireDepartmentConnectionFormDict["Inspector comments"] = "Yes"
        
     
        fireDepartmentConnectionFormDictString = fireDepartmentConnectionFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(fireDepartmentConnectionFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Sprinkler Heads
extension PdfJsonHandler {
    func setupSprinklerHeadsFormDict() {
        sprinklerHeadsFormDict["Sprinklers are visually free of corrosion, paint or foreign materials?"] = "Yes"
        sprinklerHeadsFormDict["Sprinklers are less than 50 years old?"] = "Yes"
        sprinklerHeadsFormDict["Residential & quick response sprinklers are less than 20 years old?"] = "Yes"
        sprinklerHeadsFormDict["Sprinklers are of proper temperature rating?"] = "Yes"
        sprinklerHeadsFormDict["The stock of spare sprinklers is of adequate number and type?"] = "Yes"
        sprinklerHeadsFormDict["Make of sprinklers"] = "Yes"
        sprinklerHeadsFormDict["Temperature of sprinklers"] = "Yes"
        sprinklerHeadsFormDict["Model of sprinklers."] = "Yes"
        sprinklerHeadsFormDict["Year of sprinklers"] = "Yes"
        sprinklerHeadsFormDict["Approximately number of sprinklers"] = "Yes"
        sprinklerHeadsFormDict["Finish of sprinklers"] = "Yes"
        sprinklerHeadsFormDict["Finish of escutcheons"] = "Yes"
        sprinklerHeadsFormDict["Spare head wrench available?"] = "Yes"
        sprinklerHeadsFormDict["Sprinkler spray patterns are Not obstructed?"] = "Yes"
        sprinklerHeadsFormDict["All protected areas have adequate sprinkler coverage? "] = "Yes"
        sprinklerHeadsFormDict["Dry pendent sprinklers older than 10 years replaced?"] = "Yes"
        sprinklerHeadsFormDict["Make of dry pendant"] = "Yes"
        sprinklerHeadsFormDict["Model of dry pendant"] = "Yes"
        sprinklerHeadsFormDict["Year of dry pendant "] = "Yes"
        sprinklerHeadsFormDict["Approximate number of dry pendant"] = "Yes"
        sprinklerHeadsFormDict["Finish of dry pendant"] = "Yes"
        sprinklerHeadsFormDict["Sprinklers are not subject to recall?"] = "Yes"
        sprinklerHeadsFormDict["Sprinklers with glass bulbs look to be full of liquid?"] = "Yes"
        sprinklerHeadsFormDict["Are all required sprinkler tests up to date?"] = "Yes"
        sprinklerHeadsFormDict["Deficiency"] = "Yes"
        sprinklerHeadsFormDict["Inspector comments"] = "Yes"
      
        
     
        sprinklerHeadsFormDictString = sprinklerHeadsFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(sprinklerHeadsFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Wet Pipe
extension PdfJsonHandler {
    func setupWetPipeFormDict() {
        wetPipeFormDict["Alarm valves in satisfactory condition? "] = "Yes"
        wetPipeFormDict["Retard chamber in satisfactory condition? "] = "Yes"
        wetPipeFormDict["All flow indicators in good working condition?"] = "Yes"
        wetPipeFormDict["Record time for flow switch in seconds"] = "Yes"
        wetPipeFormDict["Were all sectional/floor control valves inspected?"] = "Yes"
        wetPipeFormDict["Number of valves "] = "Yes"
        wetPipeFormDict["Were all sectional/floor flow switches inspected?"] = "Yes"
        wetPipeFormDict["Flow switch average times in seconds"] = "Yes"
        wetPipeFormDict["Are all other valves in good condition?"] = "Yes"
        wetPipeFormDict["Are cold weather valves open or closed as needed?"] = "Yes"
        wetPipeFormDict["Antifreeze systems satisfactorily tested?"] = "Yes"
        wetPipeFormDict["Type of Antifreeze solution"] = "Yes"
        wetPipeFormDict["Antifreeze solution tested @ [degrees]"] = "Yes"
        wetPipeFormDict["At what percent"] = "Yes"
        wetPipeFormDict["Approximate volume"] = "Yes"
        wetPipeFormDict["Are valve room heaters operating properly?"] = "Yes"
        wetPipeFormDict["Backflow tested as required?"] = "Yes"
        wetPipeFormDict["Forward flow test performed as required ?"] = "Yes"
        wetPipeFormDict["Are valve rooms accessible with adequate clearance?"] = "Yes"
        wetPipeFormDict["Was a main drain test performed with satisfactory results?"] = "Yes"
        wetPipeFormDict["Static pressure"] = "Yes"
        wetPipeFormDict["Residual pressure"] = "Yes"
        wetPipeFormDict["Size of main drain"] = "Yes"
        wetPipeFormDict["Main drain fully open and flow observed?"] = "Yes"
        wetPipeFormDict["If no main drain test was performed state explanation "] = "Yes"
        wetPipeFormDict["Gauges replaced or calibrated "] = "Yes"
        wetPipeFormDict["Are all other valves open or closed as required?"] = "Yes"
        wetPipeFormDict["Has internal investigation been performed in last 5 years?"] = "Yes"
        wetPipeFormDict["Alarm panel reset and clear of alarms? "] = "Yes"
        wetPipeFormDict["Alarm valve identification"] = "Yes"
        wetPipeFormDict["Make of alarm valve"] = "Yes"
        wetPipeFormDict["Size of alarm valve"] = "Yes"
        wetPipeFormDict["Year of alarm valve"] = "Yes"
        wetPipeFormDict["Date of last inspection"] = "Yes"
        wetPipeFormDict["Was system tagged? "] = "Yes"
        wetPipeFormDict["If Tagged what color"] = "Yes"
        wetPipeFormDict["Deficiency"] = "Yes"
        wetPipeFormDict["Inspector comments"] = "Yes"
        
        wetPipeFormDictString = wetPipeFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(wetPipeFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Dry Pipe
extension PdfJsonHandler {
    func setupDryPipeFormDict() {
        dryPipeFormDict["Type of system"] = "Yes"
        dryPipeFormDict["Dry valve in service and in good condition?"] = "Yes"
        dryPipeFormDict["Dry valve identification"] = "Yes"
        dryPipeFormDict["Make of dry valve"] = "Yes"
        dryPipeFormDict["Model of dry valve"] = "Yes"
        dryPipeFormDict["Size of dry valve in inches"] = "Yes"
        dryPipeFormDict["Year of dry valve"] = "Yes"
        dryPipeFormDict["Main drain test performed with satisfactory results?"] = "Yes"
        dryPipeFormDict["Static pressure"] = "Yes"
        dryPipeFormDict["Residual pressure"] = "Yes"
        dryPipeFormDict["Gauges replaced or calibrated?"] = "Yes"
        dryPipeFormDict["Air pressure set at correct level?"] = "Yes"
        dryPipeFormDict["Cut off pressure"] = "Yes"
        dryPipeFormDict["Cut in pressure"] = "Yes"
        dryPipeFormDict["Low air pressure switch activates at"] = "Yes"
        dryPipeFormDict["Date of last trip test"] = "Yes"
        dryPipeFormDict["Dry valve successfully trip tested and returned to service?"] = "Yes"
        dryPipeFormDict["Dry valve in service and in good condition ?"] = "Yes"
        dryPipeFormDict["Model of dry valve"] = "Yes"
        dryPipeFormDict["Pressures before testing air #"] = "Yes"
        dryPipeFormDict["Dry valve identification"] = "Yes"
        dryPipeFormDict["Water #"] = "Yes"
        dryPipeFormDict["Control valve fully open?"] = "Yes"
        dryPipeFormDict["Operated @ air pressure"] = "Yes"
        dryPipeFormDict["Time it took to trip [seconds]"] = "Yes"
        dryPipeFormDict["Time for water to reach inspectors test [seconds]"] = "Yes"
        dryPipeFormDict["Interior of dry valve was satisfactory including all moving parts?"] = "Yes"
        dryPipeFormDict["Trip test performed without repairs?"] = "Yes"
        dryPipeFormDict["Did alarms work during test?"] = "Yes"
        dryPipeFormDict["Quick opening devices operate properly and reset?"] = "Yes"
        dryPipeFormDict["Make of quick opening device"] = "Yes"
        dryPipeFormDict["Model of quick opening device"] = "Yes"
        dryPipeFormDict["Year of quick opening device"] = "Yes"
        dryPipeFormDict["Condition of quick opening device"] = "Yes"
        dryPipeFormDict["Valve reset dry?"] = "Yes"
        dryPipeFormDict["All supervisory devices successfully tested?"] = "Yes"
        dryPipeFormDict["All automatic release devices tested?"] = "Yes"
        dryPipeFormDict["Manual release devices tested?"] = "Yes"
        dryPipeFormDict["Quick-opening devices successfully tested?"] = "Yes"
        dryPipeFormDict["Priming water level is normal?"] = "Yes"
        dryPipeFormDict["All low points drained at fall inspection?"] = "Yes"
        dryPipeFormDict["Number of auxiliary drains"] = "Yes"
        dryPipeFormDict["Has an assessment of the internal condition of piping been performed during the past 5 years"] = "Yes"
        dryPipeFormDict["Date of last inspection"] = "Yes"
        dryPipeFormDict["Has piping been checked for proper slope in the last 10 years?"] = "Yes"
        dryPipeFormDict["Are all other valves in their proper position?"] = "Yes"
        dryPipeFormDict["Is valve room adequately heated?"] = "Yes"
        dryPipeFormDict["Alarm panels reset and clear of alarms?"] = "Yes"
        dryPipeFormDict["Was System Tagged?"] = "Yes"
        dryPipeFormDict["Tag color?"] = "Yes"
        dryPipeFormDict["Deficiencies"] = "Yes"
        dryPipeFormDict["Inspector comments"] = "Yes"
        
        dryPipeFormDictString = dryPipeFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(dryPipeFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Tanks
extension PdfJsonHandler {
    func setupTanksFormDict() {
        tanksFormDict["Water temperature- low temperature alarms tested?"] = "Yes"
        tanksFormDict["Heating system tested and in satisfactory condition?"] = "Yes"
        tanksFormDict["Tank fill valve in satisfactory condition?"] = "Yes"
        tanksFormDict["Control valves in normal position?"] = "Yes"
        tanksFormDict["Water level alarms tested?"] = "Yes"
        tanksFormDict["Air pressure in tank normal?"] = "Yes"
        tanksFormDict["Condition of exterior of tank satisfactory?"] = "Yes"
        tanksFormDict["Tank support structure appears to be in good condition?"] = "Yes"
        tanksFormDict["Catwalks and ladders in satisfactory condition?"] = "Yes"
        tanksFormDict["Interior of tank in satisfactory condition?"] = "Yes"
        tanksFormDict["Area around tank in satisfactory condition?"] = "Yes"
        tanksFormDict["3 year inspections completed as required?"] = "Yes"
        tanksFormDict["Date of last inspection"] = "Yes"
        tanksFormDict["5 year inspections completed as required?"] = "Yes"
        tanksFormDict["Date of last inspection"] = "Yes"
        tanksFormDict["Was System Tagged?"] = "Yes"
        tanksFormDict["If Tagged Tag Color"] = "Yes"
        tanksFormDict["Deficiencies"] = "Yes"
      
        tanksFormDictString = tanksFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(tanksFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Foam
extension PdfJsonHandler {
    func setupFoamFormDict() {
        foamFormDict["Discharge device location (Sprinkler)"] = "Yes"
        foamFormDict["Discharge device location (Spray nozzle)"] = "Yes"
        foamFormDict["Discharge device position (Sprinkler)"] = "Yes"
        foamFormDict["Discharge device position (Spray nozzle)"] = "Yes"
        foamFormDict["Foam concentrate strainers inspected as required?"] = "Yes"
        foamFormDict["Proportioning systems inspected as required?"] = "Yes"
        foamFormDict["Pipe corrosion investigated as required?"] = "Yes"
        foamFormDict["Pipe system in satisfactory condition?"] = "Yes"
        foamFormDict["Storage tanks for foam supply in satisfactory condition?"] = "Yes"
        foamFormDict["Capacity of tank"] = "Yes"
        foamFormDict["Type of foam used in system"] = "Yes"
        foamFormDict["Number of tanks in system"] = "Yes"
        foamFormDict["Foam concentrate tested and in satisfactory condition?"] = "Yes"
        foamFormDict["Actuation devices tested and in satisfactory condition?"] = "Yes"
        foamFormDict["Detection devices tested as required?"] = "Yes"
        foamFormDict["5 year maintenance completed as required?"] = "Yes"
        foamFormDict["Date of last 5 year maintenance"] = "Yes"
        foamFormDict["10 year maintenance completed as required"] = "Yes"
        foamFormDict["Date of last 10 year maintenance"] = "Yes"
        foamFormDict["Was System Tagged?"] = "Yes"
        foamFormDict["If Tagged what color"] = "Yes"
        foamFormDict["Deficiencies"] = "Yes"
        foamFormDict["Foam comments"] = "Yes"
        
      
        foamFormDictString = foamFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(foamFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Standpipe
extension PdfJsonHandler {
    func setupStandpipeFormDict() {
        standpipeFormDict["Visual inspection of entire system?"] = "Yes"
        standpipeFormDict["A There have been No modifications since the last inspection?"] = "Yes"
        standpipeFormDict["All systems are in service?"] = "Yes"
        standpipeFormDict["Control valves are in the open position?"] = "Yes"
        standpipeFormDict["Control valves are locked open or have tamper switches?"] = "Yes"
        standpipeFormDict["No indication of serious corrosion?"] = "Yes"
        standpipeFormDict["Hangers and supports are secured to pipe and building structure?"] = "Yes"
        standpipeFormDict["FDC is accessible and uNobstructed?"] = "Yes"
        standpipeFormDict["FDC inlets are Not obstructed by foreign material? "] = "Yes"
        standpipeFormDict["FDC plugs and caps are in place?"] = "Yes"
        standpipeFormDict["FDC swivel connections turn freely?"] = "Yes"
        standpipeFormDict["Hose valves are operable and have caps? "] = "Yes"
        standpipeFormDict["Are hoses in service as required?"] = "Yes"
        standpipeFormDict["Hose in racks have been tested in last 5 years and have adjustable Nozzles"] = "Yes"
        standpipeFormDict["Standpipe classification"] = "Yes"
        standpipeFormDict["Was 5 year flow test performed as required?"] = "Yes"
        standpipeFormDict["Was 5 year hydrostatic test performed as required"] = "Yes"
        standpipeFormDict["Was system tagged"] = "Yes"
        standpipeFormDict["Date of last test"] = "Yes"
        standpipeFormDict["Number of hose racks"] = "Yes"
        standpipeFormDict["Date of last flow test inspection"] = "Yes"
        standpipeFormDict["If tagged what color"] = "Yes"
        standpipeFormDict["Date of last hydrostatic test inspection"] = "Yes"
        standpipeFormDict["Deficiency"] = "Yes"
        standpipeFormDict["Inspector comments"] = "Yes"
   
      
        standpipeFormDictString = standpipeFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(standpipeFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Pump
extension PdfJsonHandler {
    func setupPumpFormDict() {
        pumpFormDict["Add this section to report"] = "Yes"
        pumpFormDict["Type of pump"] = "Yes"
        pumpFormDict["Pump Manufacturer"] = "Yes"
        pumpFormDict["Serial number"] = "Yes"
        pumpFormDict["Model number"] = "Yes"
        pumpFormDict["Pump Label"] = "Yes"
        pumpFormDict["Rated volume"] = "Yes"
        pumpFormDict["Rated pressure"] = "Yes"
        pumpFormDict["Rated rpm"] = "Yes"
        pumpFormDict["Supply from"] = "Yes"
        pumpFormDict["Driver"] = "Yes"
        pumpFormDict["Driver Manufacturer"] = "Yes"
        pumpFormDict["Driver Serial number"] = "Yes"
        pumpFormDict["Driver Model number"] = "Yes"
        pumpFormDict["Driver Rated house power"] = "Yes"
        pumpFormDict["Driver Rated speed"] = "Yes"
        pumpFormDict["If electric motor: Driver rated voltage"] = "Yes"
        pumpFormDict["Driver Operating voltage"] = "Yes"
        pumpFormDict["Rated amps"] = "Yes"
        pumpFormDict["Phase cycles"] = "Yes"
        pumpFormDict["Controller: manufacturer"] = "Yes"
        pumpFormDict["Controller Serial number"] = "Yes"
        pumpFormDict["Model number"] = "Yes"
        pumpFormDict["Controller Label"] = "Yes"
        pumpFormDict["Jockey pump on system?"] = "Yes"
        pumpFormDict["JOCKEY PUMP settings: on pressure"] = "Yes"
        pumpFormDict["Off pressure"] = "Yes"
        pumpFormDict["Jockey Label"] = "Yes"
        pumpFormDict["Deficiencies"] = "Yes"
        pumpFormDict["Inspector comments"] = "Yes"
      
      
        pumpFormDictString = pumpFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(pumpFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Flow Test
extension PdfJsonHandler {
    func setupFlowTestFormDict() {
        flowTestFormDict["Flow Test Table"] = "Yes"
        flowTestFormDict["For electric driven fire pump record voltage and amps"] = "Yes"
        flowTestFormDict["Flow test completed with the use of # of pitot tubes"] = "Yes"
        flowTestFormDict["Flow Meter is functional"] = "Yes"
        flowTestFormDict["Pitot pressure used to measure flow"] = "Yes"
        flowTestFormDict["Main drain test static"] = "Yes"
        flowTestFormDict["Residual presure"] = "Yes"
        flowTestFormDict["Time for supply to reach normal pressure"] = "Yes"
        flowTestFormDict["Adequate drainage provided before flow testing?"] = "Yes"
        flowTestFormDict["Pump suction and discharge pressures and flow measurements at each hose stream used to determine total pump output where hose streams used in testing?"] = "Yes"
        flowTestFormDict["Care taken to prevent water damage by verifying adequate drainage?"] = "Yes"
        flowTestFormDict["Flow test conducted under minimum, rated and peak fire pump flows?"] = "Yes"
        flowTestFormDict["Flow test conducted by controlling quantity of water discharged through test devices?"] = "Yes"
        flowTestFormDict["Fire pump operated at maximum allowable discharge?"] = "Yes"
        flowTestFormDict["Fire pump suction supply provided required flow at 0 pressure or higher gauge pressure at pump suction flange?"] = "Yes"
        flowTestFormDict["Electric fire pump driver did not overload beyond rating while delivering necessary brake horsepower?"] = "Yes"
        flowTestFormDict["Pump suction and discharge pressures and flowmeter measurements used to determine total pump output where flow meter used in testing?"] = "Yes"
        flowTestFormDict["Flow meter adjusted immediately prior to testing in accordance with mfg. instructions?"] = "Yes"
        flowTestFormDict["Test results using flow meter consistent with previous annual test results (IF no, complete flow test using hose streams OR calibrate flow meter)"] = "Yes"
        flowTestFormDict["Deficiencies"] = "Yes"
        flowTestFormDict["Inspector comments"] = "Yes"
      
        flowTestFormDictString = flowTestFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(flowTestFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - While Pump ls Running
extension PdfJsonHandler {
    func setupWhilePumplsRunningFormDict() {
        whilePumplsRunningFormDict["At churn, circulation relief valve checked for operation and water discharge?"] = "Yes"
        whilePumplsRunningFormDict["At churn, pressure relief valve checked for proper operation?"] = "Yes"
        whilePumplsRunningFormDict["At churn, pressure control valve checked for proper operation?"] = "Yes"
        whilePumplsRunningFormDict["At churn, test continued for minimum of [Minutes]"] = "Yes"
        whilePumplsRunningFormDict["At each flow condition, electric motor voltage and current in all lines recorded?"] = "Yes"
        whilePumplsRunningFormDict["At each flow condition, pump speed recorded?"] = "Yes"
        whilePumplsRunningFormDict["At each flow condition, simultaneous readings of pump suction and discharge pressures and pump discharge flow recorded?"] = "Yes"
        whilePumplsRunningFormDict["Pressure relief valve closely observed during each flow condition?"] = "Yes"
        whilePumplsRunningFormDict["Pressure control valve closely observed during each flow condition?"] = "Yes"
        whilePumplsRunningFormDict["Pressure relief valve functioning properly?"] = "Yes"
        whilePumplsRunningFormDict["Pressure control valve functioning properly?"] = "Yes"
        whilePumplsRunningFormDict["Pressure relief valve closed by pilot adjustment during flow conditions?"] = "Yes"
        whilePumplsRunningFormDict["Pressure relief valve reset to normal position at pump test conclusion?"] = "Yes"
        whilePumplsRunningFormDict["Deficiencies"] = "Yes"
        whilePumplsRunningFormDict["Inspector comments"] = "Yes"
      
        whilePumplsRunningFormDictString = whilePumplsRunningFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(whilePumplsRunningFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Check List
extension PdfJsonHandler {
    func setupCheckListFormDict() {
        checkListFormDict["System in service on arrival?"] = "Yes"
        checkListFormDict["Responsible parties notified before testing?"] = "Yes"
        checkListFormDict["Alarm company notified before testing?"] = "Yes"
        checkListFormDict["Control valves in normally open or normally closed position?"] = "Yes"
        checkListFormDict["Control valves properly locked or supervised?"] = "Yes"
        checkListFormDict["Control valve supervisory switches initiate signal properly?"] = "Yes"
        checkListFormDict["Signal restored only when valve returned to normal position?"] = "Yes"
        checkListFormDict["Operating stems of OS&Y valves lubricated?"] = "Yes"
        checkListFormDict["Control valves operated through full range and returned to normal position?"] = "Yes"
        checkListFormDict["Control valves are free from external leaks?"] = "Yes"
        checkListFormDict["Control valve identification signs in place?"] = "Yes"
        checkListFormDict["Battery systems in satisfactory condition?"] = "Yes"
        checkListFormDict["Battery system charger and charge rate operational, normal and equalized?"] = "Yes"
        checkListFormDict["Circuit breakers or fuses checked?"] = "Yes"
        checkListFormDict["Isolating switch exercised?"] = "Yes"
        checkListFormDict["Circuit breakers exercised?"] = "Yes"
        checkListFormDict["crankcase breather inspected and in good condition?"] = "Yes"
        checkListFormDict["Engine exhaust system inspected and in satisfactory condition?"] = "Yes"
        checkListFormDict["Electrical wiring subject to movement free from chafing?"] = "Yes"
        checkListFormDict["Strainer, filter or dirt leg (or combination thereof) cleaned?"] = "Yes"
        checkListFormDict["Crankcase breather cleaned or changed (as necessary)?"] = "Yes"
        checkListFormDict["Water strainer cleaned?"] = "Yes"
        checkListFormDict["Manual starting means of electrically driven pumps operated?"] = "Yes"
        checkListFormDict["Antifreeze protection level tested and adjusted as necessary?"] = "Yes"
        checkListFormDict["Electrical system safety devices and alarms operated?"] = "Yes"
        checkListFormDict["Electrical system boxes, panels and cabinets cleaned?"] = "Yes"
        checkListFormDict["Hangers and seismic bracing appear undamaged and tightly attached?"] = "Yes"
        checkListFormDict["Piping appears free of mechanical damage and in satisfactory condition?"] = "Yes"
        checkListFormDict["Building is secure such as not to expose piping to freezing conditions?"] = "Yes"
        checkListFormDict["Adequate heat is provided maintaining temp at 40°F / 4.4°C or higher?"] = "Yes"
        checkListFormDict["Pump shaft end play with specified tolerances?"] = "Yes"
        checkListFormDict["Pressure gauge and sensor accuracy verified to be within 5%?"] = "Yes"
        checkListFormDict["Pump coupling alignment within specified tolerances?"] = "Yes"
        checkListFormDict["Electrical connections tightened as necessary?"] = "Yes"
        checkListFormDict["Mechanical moving parts lubrication verified?"] = "Yes"
        checkListFormDict["Pressure switch setting calibration verified?"] = "Yes"
        checkListFormDict["Fuel tank vents and overflow piping free from obstructions?"] = "Yes"
        checkListFormDict["Fuel piping in good condition?"] = "Yes"
        checkListFormDict["Combustion air ductwork and louvers in good condition?"] = "Yes"
        checkListFormDict["Electrical control and power wiring connections checked for tightness?"] = "Yes"
        checkListFormDict["pump bearing lubricated?"] = "Yes"
        checkListFormDict["Gauges recalibrated or changed?"] = "Yes"
        checkListFormDict["Wet pit suction screens checked (cleaned as necessary) after every operation?"] = "Yes"
        checkListFormDict["Mechanical transmission coupling lubricated?"] = "Yes"
        checkListFormDict["Mechanical transmission right-angle gear drive lubricated?"] = "Yes"
        checkListFormDict["Electric drive motor bearings lubricated?"] = "Yes"
        checkListFormDict["Diesel engine maintenance schedule up to date as required?"] = "Yes"
        checkListFormDict["Diesel engine cooling system antifreeze checked?"] = "Yes"
        checkListFormDict["Electrical system circuit breakers or fuses changed (every 2 years)?"] = "Yes"
        checkListFormDict["Deficiencies"] = "Yes"
        checkListFormDict["Inspector comments"] = "Yes"
      
        checkListFormDictString = checkListFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(checkListFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Transfer Switch
extension PdfJsonHandler {
    func setupTransferSwitchFormDict() {
        transferSwitchFormDict["Power failure condition simulated while pump operating at peak load?"] = "Yes"
        transferSwitchFormDict["Transfer switch transfer of power to alternate power source verified?"] = "Yes"
        transferSwitchFormDict["Pump maintenance of peak load performance verified?"] = "Yes"
        transferSwitchFormDict["Power failure condition removed?"] = "Yes"
        transferSwitchFormDict["Pump reconnected to normal power source after a time delay?"] = "Yes"
        transferSwitchFormDict["Was system tagged?"] = "Yes"
        transferSwitchFormDict["If tagged what color?"] = "Yes"
        transferSwitchFormDict["Deficiencies"] = "Yes"
        transferSwitchFormDict["Inspector comments"] = "Yes"
      
        transferSwitchFormDictString = transferSwitchFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(transferSwitchFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Extinguishers
extension PdfJsonHandler {
    func setupExtinguishersFormDict() {
        extinguishersFormDict["Total number of extinguishers inspected."] = "Yes"
        extinguishersFormDict["Are all extinguishers visible?"] = "Yes"
        extinguishersFormDict["Are all extinguishers accessible?"] = "Yes"
        extinguishersFormDict["Are all extinguishers in good condition?"] = "Yes"
        extinguishersFormDict["Are extinguisher cabinets in good condition?"] = "Yes"
        extinguishersFormDict["Are all pressure gauges and pull pins in good condition?"] = "Yes"
        extinguishersFormDict["Are all extinguishers of the proper class?"] = "Yes"
        extinguishersFormDict["Do extinguishers cover the proper square footage for the hazard protected?"] = "Yes"
        extinguishersFormDict["Are all extinguisher labels in place?"] = "Yes"
        extinguishersFormDict["Have all maintenance intervals been performed?"] = "Yes"
        extinguishersFormDict["Date of last maintenance interval"] = "Yes"
        extinguishersFormDict["6 year maintenance"] = "Yes"
        extinguishersFormDict["12 year hydro test"] = "Yes"
        extinguishersFormDict["5 year hydro test"] = "Yes"
        extinguishersFormDict["Other"] = "Yes"
        extinguishersFormDict["Are all hoses and nozzles in good condition?"] = "Yes"
        extinguishersFormDict["Was system tagged?"] = "Yes"
        extinguishersFormDict["Deficiencies"] = "Yes"
        extinguishersFormDict["Inspector comments"] = "Yes"
   
      
        extinguishersFormDictString = extinguishersFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(extinguishersFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

// MARK: - Fire Hydrants
extension PdfJsonHandler {
    func setupFireHydrantsFormDict() {
        fireHydrantsFormDict["Year"] = "Yes"
        fireHydrantsFormDict["Location"] = "Yes"
        fireHydrantsFormDict["Date"] = "Yes"
        fireHydrantsFormDict["There are no leaks in the hydrant ?"] = "Yes"
        fireHydrantsFormDict["Operating nut is not worn and does not have rounded corners ?"] = "Yes"
        fireHydrantsFormDict["System"] = "Yes"
        fireHydrantsFormDict["Hydrant outlets are slightly more than hand-tight ?"] = "Yes"
        fireHydrantsFormDict["There are no cracks in the hydrant barrel ?"] = "Yes"
        fireHydrantsFormDict["Nozzels threads are not damaged ?"] = "Yes"
        fireHydrantsFormDict["Deficiencies"] = "Yes"
        fireHydrantsFormDict["Inspector comments"] = "Yes"
      
      
        fireHydrantsFormDictString = fireHydrantsFormDict.jsonStringRepresentaiton ?? ""
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
        print(fireHydrantsFormDictString)
        print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
    }
}

extension Dictionary {
    var jsonStringRepresentaiton: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) else { return nil }
        return String(data: theJSONData, encoding: String.Encoding.utf8)
    }
}
