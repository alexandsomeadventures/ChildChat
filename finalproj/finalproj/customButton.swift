

import UIKit

class customButton: UIButton {
    
    enum fontSize{
        case big
        case med
        case small
        
        
    }
    init(title: String, hasBackground: Bool = false, fontsize: fontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        //limits all unnecessary things within bounds only if button has overflow or extends out of boundaries
        
        self.backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor  = hasBackground ? .white : .systemBlue
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontsize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight:  .bold)
            
        case .med:
            
            self.titleLabel?.font = .systemFont(ofSize: 18, weight:  .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight:  .regular)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
