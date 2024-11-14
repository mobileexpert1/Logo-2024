//
//  CreateProjectVC.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit



import iOSDropDown
import CoreLocation


class CreateProjectVC: UIViewController ,CLLocationManagerDelegate {
    
    @IBOutlet weak var txt_FldProjectName: UITextField!
    @IBOutlet weak var txt_FldContractorName: UITextField!
    @IBOutlet weak var txt_FldAddressName: UITextField!
  
    @IBOutlet weak var imgVwback: UIImageView!
    @IBOutlet weak var txt_FldStateName: DropDown!
    @IBOutlet weak var txt_FldCityName: UITextField!
    @IBOutlet weak var txt_FldPostalName: UITextField!
    
    @IBOutlet weak var back_Img: UIImageView!
    @IBOutlet weak var baseVw: UIView!
    
    var locManager : CLLocationManager?
    var lat = ""
    var long = ""
    
    var statesArray = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager?.requestAlwaysAuthorization()
        txt_FldStateName.optionArray = statesArray
        txt_FldStateName.didSelect { [self] selectedText, index, id in
            print("Selected Text \(selectedText)")
         
        }
        self.LocationDidloadRequirements()
        self.txt_FldProjectName.setLeftPaddingPoints(10)
        self.txt_FldContractorName.setLeftPaddingPoints(10)
        self.txt_FldContractorName.setLeftPaddingPoints(10)
        self.txt_FldStateName.setLeftPaddingPoints(10)
        self.txt_FldPostalName.setLeftPaddingPoints(10)
        self.txt_FldCityName.setLeftPaddingPoints(10)
        updateBackgroundColors()
        imgVwback.actionBlock {
            self.navigationController?.popViewController(animated: true);
        }
    }
    func LocationDidloadRequirements(){
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
      
        txt_FldProjectName.layer.cornerRadius = 12
        txt_FldContractorName.layer.cornerRadius = 12
        txt_FldAddressName.layer.cornerRadius = 12
        txt_FldStateName.layer.cornerRadius = 12
        txt_FldCityName.layer.cornerRadius = 12
        txt_FldPostalName.layer.cornerRadius = 12
    }
    
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                // Dark mode is enabled
                baseVw.backgroundColor = ThemeColor.lightThemeImageTintColor
                self.view.backgroundColor = ThemeColor.lightThemeImageTintColor
        
              
                imgVwback.tintColor = ThemeColor.darkThemeImageTintColor
            }
            else{
                imgVwback.tintColor = ThemeColor.lightThemeImageTintColor
            }
        }
    }
    
    func updateBackgroundColors() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
                    txt_FldAddressName.attributedPlaceholder = NSAttributedString(
                        string: " Enter Address",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldProjectName.attributedPlaceholder = NSAttributedString(
                        string: " Enter Project Name",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldContractorName.attributedPlaceholder = NSAttributedString(
                        string: "Enter Contractor Name ",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldCityName.attributedPlaceholder = NSAttributedString(
                        string: "Enter City",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldPostalName.attributedPlaceholder = NSAttributedString(
                        string: "Enter Postal Code",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldStateName.attributedPlaceholder = NSAttributedString(
                        string: "Enter State",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                   
                } else {
                    txt_FldAddressName.attributedPlaceholder = NSAttributedString(
                        string: "  Enter Address",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldProjectName.attributedPlaceholder = NSAttributedString(
                        string: "Enter Project Name",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldContractorName.attributedPlaceholder = NSAttributedString(
                        string: "Enter Contractor Name ",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldCityName.attributedPlaceholder = NSAttributedString(
                        string: "Enter City",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldPostalName.attributedPlaceholder = NSAttributedString(
                        string: "Enter Postal Code",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                    txt_FldStateName.attributedPlaceholder = NSAttributedString(
                        string: "Enter State",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
                    )
                  
                }
            } else {
                // Fallback for earlier versions
            //    UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }
    
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        if txt_FldProjectName.text!.isEmpty || txt_FldAddressName.text!.isEmpty || txt_FldCityName.text!.isEmpty || txt_FldStateName.text!.isEmpty || txt_FldPostalName.text!.isEmpty || txt_FldContractorName.text!.isEmpty {
            showOnlyAlert("Poseidon", message: "Kindly fill all fields.")
        }
        else{
            CreateProjectAPI()
        }
    }
    
    func CreateProjectAPI(){
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
            
            let params = ["sessionToken" : SingleTon.shared.userToken,"name" : txt_FldProjectName.text!,"contractorName" : txt_FldContractorName.text!,"lat" : lat,"long" : long,"address" : txt_FldAddressName.text!,"city" : txt_FldCityName.text!,"state" : txt_FldStateName.text!,"postalCode" : txt_FldPostalName.text!] as [String : Any]
            ApiFunc.shared.APIHeaderMethod(url: ApiUrl.CreateProjectUrl, method: .post, parameters: params) { [self] (success : CreateProjectModel?) in
                AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
                print("fdhgh", params)
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBackgroundColor()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

   
    }


extension CreateProjectVC : UITextFieldDelegate{
    // MARK: - TEXTFIELD_DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txt_FldStateName{
            textField.endEditing(true)
            self.isEditing = false
            self.txt_FldStateName.showList()
            return false
        }
        
        return true
    }
}
