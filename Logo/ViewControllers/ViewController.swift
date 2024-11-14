//
//  ViewController.swift
//  Logo
//
//  Created by Nihal kamboj on 04/03/22.

//  color code == e0e8ee

//       Font Name

//        family: Lato
//        name:Lato-Regular
//        name:Lato-Hairline
//        name:Lato-Light
//        name:Lato-Bold



import UIKit
import Alamofire
import PKHUD

class ViewController: UIViewController,UITextFieldDelegate {
    
    var  myadict = [LoginModel]()
    
    var iconClick = false
    
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    @IBOutlet weak var baseView_PassTxtField: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//                emailTxtField.text = "multilevel@gmail.com"
//                passTextField.text = "123456"
        setupUI()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateBackgroundColor()
        print("at login will appear :: userToken -> ",SingleTon.shared.userToken)
        
        passTextField.isSecureTextEntry = true
        setSecureTxtField()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func setupUI() {
        self.capsuleButton(loginBtn)
        emailTxtField.addShadow(textField: emailTxtField)
        passTextField.addShadow(textField: baseView_PassTxtField)
        emailTxtField.setLeftPaddingPoints(20)
        passTextField.setLeftPaddingPoints(20)
        
        emailTxtField.delegate = self
        passTextField.delegate = self
        
        emailTxtField.tag = 0
        passTextField.tag = 1
        
        self.view.addTapGestureRecognizer(){
            self.view.hideKeyboard()
        }
    }
    
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                self.view.backgroundColor = .white
                self.eyeImageView.tintColor = .systemBlue
                emailTxtField.attributedPlaceholder = NSAttributedString(string: "Enter E-mail address",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                passTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            }
            else{
                self.view.backgroundColor = .white
                self.eyeImageView.tintColor = .systemBlue
            }
        }
        }
    
    
    @IBAction func logintBtn(_ sender: UIButton) {

        
        if emailTxtField.text == "" || passTextField.text == "" {
            self.showOnlyAlert("Alert", message: "Please enter Email ")
            
        } else if passTextField.text == "" {
            self.showOnlyAlert("Alert", message: "Please enter Password ")
        }
        loginApi()
        //loginApiMethod()
    }
    
    func setSecureTxtField() {
        eyeImageView.addTapGestureRecognizer() {
            if(self.iconClick == true) {
                self.passTextField.isSecureTextEntry = true
                self.eyeImageView.image = UIImage(systemName: "eye.slash")
            } else {
                self.passTextField.isSecureTextEntry = false
                self.eyeImageView.image = UIImage(systemName: "eye")
            }
            
            self.iconClick = !self.iconClick
        }
    }
    
    func loginApi() {
       // executWorkOrderHome()
        ApiFunc.shared.loginApi(self.view, username: self.emailTxtField.text!, password: self.passTextField.text!) { responseModel in
            if responseModel.status == true {
                let token = responseModel.data?.token
                SingleTon.shared.userToken = token!
                SingleTon.shared.MyLoginID = (responseModel.data?.inspectorData?.id)!
                print(token)
                PKHUD.sharedHUD.hide()

               
          //      let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
             //  let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalanderHomeVC") as! CalanderHomeVC
                
               
                SingleTon.shared.appId = (responseModel.data?.inspectorData?.role)!
                switch responseModel.data?.inspectorData?.role {
                   
                case "3":
                    SingleTon.shared.appProfileArr = ["Clock In/Out","Work Orders","Inspections"]
                case "4":
                    SingleTon.shared.appSelected = false
                    SingleTon.shared.appProfileArr = ["Clock In/Out","Work Orders"]
                default:
                    SingleTon.shared.appProfileArr = ["Clock In/Out","Work Orders"]
                }
                if responseModel.data?.inspectorData?.isClockedIn == 1{
                    SingleTon.shared.isClockedIn = true
                }
                else if responseModel.data?.inspectorData?.isClockedIn == 0{
                    SingleTon.shared.isClockedIn = false
                }
                self.executPoseidonHome()
            } else {
                PKHUD.sharedHUD.hide()
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
                self.showOnlyAlert("Alert", message: responseModel.message ?? "")
            }
        }
    }
    
     func openTapped() {
        let ac = UIAlertController(title: "Select App", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Poseidon", style: .default, handler: selectPoseidonApp))
        ac.addAction(UIAlertAction(title: "WorkOrder", style: .default, handler: selectWorkOrderApp))
        present(ac, animated: true)
    }
    
    func selectPoseidonApp(action: UIAlertAction) {
        self.executHome()
        SingleTon.shared.appSelected = true
    }
    func selectWorkOrderApp(action: UIAlertAction) {
        self.executWorkOrderHome()
        SingleTon.shared.appSelected = false
    }
    
    // MARK: - Functions
    // POSEIDON
    func executHome() {
        let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_VC")
        UIApplication.shared.currentWindow?.rootViewController = homeRootVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
    // WORK ORDER
    func executWorkOrderHome() {
        let homeRootVC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderViewNav")
        UIApplication.shared.currentWindow?.rootViewController = homeRootVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
    // MAIN_HOME
    func executPoseidonHome() {
        let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Dashboard_Nav")
        UIApplication.shared.currentWindow?.rootViewController = homeRootVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
  
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            if textField.text?.isValidEmail() == true{
                print("OKKK")
            }
            else{
                self.showOnlyAlert("Alert", message: "Please Input Correct Email")
            }
        }
        return true
    }
    
    @IBAction func btn_Test(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CalanderHomeVC") as? CalanderHomeVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

