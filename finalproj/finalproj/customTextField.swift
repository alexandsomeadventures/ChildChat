

import UIKit

class customTextField: UITextField {
    enum customTextFieldType {
        case username
        case email
        case password
    }
    private let authFieldType : customTextFieldType
    
    init(fieldType: customTextFieldType){
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.returnKeyType = .next
        // if we put .done here, as soon as user finishes typing and presses done/enter key, keyboard will be dismissed.
        //.next means that when user finishes typing, pressing done key will move user to next textfield if there is any.
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        //basically , without the 2 lines below, placeholder covers left side of textfield, so we move it a little bit to center. This works for within text
        leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch authFieldType {
        case .username:
            self.placeholder = "Username"
        case .email:
            self.placeholder = "Email"
            self.keyboardType = .emailAddress
            self.returnKeyType = .continue
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Password"
            self.isSecureTextEntry = true
            self.returnKeyType = .done  // 'Done' is suitable for password fields to close the keyboard
            self.textContentType = .oneTimeCode
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
