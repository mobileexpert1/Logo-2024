//
//  CreditCard_VC.swift
//  Logo
//
//  Created by MOBILE on 06/12/23.
//

import UIKit
import SimplePDF

class CreditCard_VC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var fullName_TF: UITextField!
    @IBOutlet weak var enterDate_TF: DatePickerField!
    @IBOutlet weak var paymentDescription_TV: UITextView!
    
    @IBOutlet weak var billingAddress_TF: UITextField!
    @IBOutlet weak var billingAddressPNo_TF: UITextField!
    @IBOutlet weak var billingAddressZip_TF: UITextField!
    @IBOutlet weak var billingAddressEmail_TF: UITextField!
    @IBOutlet weak var cardName_TF: UITextField!
    @IBOutlet weak var cardNumber_TF: UITextField!
    @IBOutlet weak var cardExpiryMonth_TF: UITextField!
    @IBOutlet weak var cardExpiryYear_TF: UITextField!
    @IBOutlet weak var cardCVV_TF: UITextField!
    @IBOutlet weak var backBtn: UIImageView!
    var dataDict = [String:Any]()
    var pdf = SimplePDF(pageSize: CGSize(width: 595, height: 840))
    var jobId = String()
    var jobName = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        setActions()
    }
    
    func setUI(){
        cardExpiryMonth_TF.loadDropdownData2(data: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
        enterDate_TF.setSimpleDatePicker()
        cardExpiryYear_TF.loadDropdownData2(data: getyearsTillNow())
        
        cardNumber_TF.delegate = self
        paymentDescription_TV.delegate = self
        paymentDescription_TV.text = "(Description of goods/services)"
        paymentDescription_TV.textColor = UIColor.lightGray
            }
    func setActions(){
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    

    @IBAction func contiueBtn(_ sender: Any) {
        validations()
        
    }
    func validations(){
        if let fullName = fullName_TF.text,let enterDate = enterDate_TF.text,let paymentDescription = paymentDescription_TV.text,let billingAddress = billingAddress_TF.text,let billingAddressPNo = billingAddressPNo_TF.text,let billingAddressZip = billingAddressZip_TF.text,let billingAddressEmail = billingAddressEmail_TF.text,let cardName = cardName_TF.text ,let cardNumber = cardNumber_TF.text,let cardExpiryMonth = cardExpiryMonth_TF.text,let cardExpiryYear = cardExpiryYear_TF.text,let cardCVV = cardCVV_TF.text{
            
            
            if fullName == ""{
                showOnlyAlert("Poseidon", message: "enter name")
            }else if enterDate == ""{
                showOnlyAlert("Poseidon", message: "enter Date")
            }else if paymentDescription == ""{
                showOnlyAlert("Poseidon", message: "enter payment description")
            }
            else if billingAddress == ""{
                showOnlyAlert("Poseidon", message: "enter billing address")
            }
            else if billingAddressPNo == ""{
                showOnlyAlert("Poseidon", message: "enter billing address phone number")
            }
            else if billingAddressZip == ""{
                showOnlyAlert("Poseidon", message: "enter City,state,zip")
            }
            else if billingAddressEmail == ""{
                showOnlyAlert("Poseidon", message: "enter billing address email")
            }else if !billingAddressEmail.isValidEmail(){
                showOnlyAlert("Poseidon", message: "enter valid billing address email")
            }
            else if cardName == ""{
                showOnlyAlert("Poseidon", message: "enter card name")
            }
            
            else if cardNumber == ""{
                showOnlyAlert("Poseidon", message: "enter card number")
            }else if cardNumber.description.count != 19{
                showOnlyAlert("Poseidon", message: "enter valid card number")
            }
            else if cardExpiryMonth == ""{
                showOnlyAlert("Poseidon", message: "enter card expiry month")
            }
            else if cardExpiryYear == ""{
                showOnlyAlert("Poseidon", message: "enter card expiry year")
            }else if cardCVV == ""{
                showOnlyAlert("Poseidon", message: "enter card CVV")
            }else if cardCVV.description.count != 3{
                showOnlyAlert("Poseidon", message: "enter valid CVV")
            }
            
            else{
                // call api here
               // showInspectPopUp()
//                ApiFunc.shared.submitManualRequestApi1(self.view, self.nameTxtFld.text, self.emailTxtField.text, self.mobileTextField.text, self.address1TextField.text, self.cityTextField.text, self.stateTextField.text, self.postalCodeTextField.text, self.assignDateTextField.text, self.assignTimeTextField.text){ response in
//                    print(response)
//                    print(response.status)
//                    print(response.message)
//                    self.navigationController?.popViewController(animated: true)
//                }
            }
        }
       
        else{
            showOnlyAlert("Poseidon!", message: "fill all details and continue")
        }
    }
    
    
    
    
    func getyearsTillNow() -> [String]{

        var nextFiveYears: [String] = []
            
        let calendar = Calendar.current
            let currentDate = Date()
            
            for yearOffset in 0...5 {
                if let nextYearDate = calendar.date(byAdding: .year, value: yearOffset, to: currentDate) {
                    let year = calendar.component(.year, from: nextYearDate)
                    nextFiveYears.append(year.description)
                }
            }
            
        return nextFiveYears
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == cardNumber_TF {
                return formatCardNumber(textField: textField, shouldChangeCharactersInRange: range, replacementString: string)
            }
            return true
        }
    func formatCardNumber(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
           if textField == cardNumber_TF {
               let replacementStringIsLegal = string.rangeOfCharacter(from: NSCharacterSet(charactersIn: "0123456789").inverted) == nil

               if !replacementStringIsLegal {
                   return false
               }

               let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
               let components = newString.components(separatedBy: NSCharacterSet(charactersIn: "0123456789").inverted)
               let decimalString = components.joined(separator: "") as NSString
               let length = decimalString.length
               let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)

               if length == 0 || (length > 16 && !hasLeadingOne) || length > 19 {
                   let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                   return (newLength > 16) ? false : true
               }
               var index = 0 as Int
               let formattedString = NSMutableString()

               if hasLeadingOne {
                   formattedString.append("1 ")
                   index += 1
               }
               if length - index > 4 {
                   let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
                   formattedString.appendFormat("%@ ", prefix)
                   index += 4
               }

               if length - index > 4 {
                   let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
                   formattedString.appendFormat("%@ ", prefix)
                   index += 4
               }
               if length - index > 4 {
                   let prefix = decimalString.substring(with: NSRange(location: index, length: 4))
                   formattedString.appendFormat("%@ ", prefix)
                   index += 4
               }

               let remainder = decimalString.substring(from: index)
               formattedString.append(remainder)
               textField.text = formattedString as String
               return false
           } else {
               return true
           }
       }
}
extension CreditCard_VC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {

        if paymentDescription_TV.textColor == UIColor.lightGray {
            paymentDescription_TV.text = ""
            paymentDescription_TV.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if paymentDescription_TV.text == "" {

            paymentDescription_TV.text = "(Description of goods/services)"
            paymentDescription_TV.textColor = UIColor.lightGray
        }
    }
}
