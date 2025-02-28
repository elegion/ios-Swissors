//
//  UIStackView+Swissors.swift
//  Swissors
//
//  Created by viktor.volkov on 15.04.2022.
//

#if canImport(UIKit)
import UIKit

public extension UIStackView {
    
    convenience init(subviews: [UIView] = [],
                     axis: NSLayoutConstraint.Axis = .horizontal,
                     spacing: CGFloat = .zero,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    func addBackground(color: UIColor?) {
        guard let color = color else {
            return
        }
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = .flexibleSize
        insertSubview(subView, at: .zero)
    }
    
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        removeAllArrangedSubviews(of: UIView.self)
    }
    
    @discardableResult
    func removeAllArrangedSubviews<T: UIView>(of type: T.Type) -> [T] {
        let removedSubviews = arrangedSubviews.reduce(into: [T]()) {
            result, subview in
            
            guard let view = subview as? T else {
                return
            }
            self.removeArrangedSubview(view)
            NSLayoutConstraint.deactivate(view.constraints)
            view.removeFromSuperview()
            result.append(view)
        }
        return removedSubviews
    }
}
#endif
