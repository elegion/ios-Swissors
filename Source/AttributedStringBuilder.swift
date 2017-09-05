//
//  AttributedStringBuilder.swift
//  Swissors
//
//  Created by Andrey Nazarov on 28/08/2017.
//  Copyright © 2017 SB. All rights reserved.
//

import UIKit

public enum AttributedStringBuilderError: Swift.Error {
    case attributeNotFoundError
}

extension String {
    
    var attribute: AttributedStringBuilder {
        return AttributedStringBuilder(base: self, attributes: [])
    }
    
    fileprivate var fullRange: NSRange {
        return NSRange(location: 0, length: self.characters.count)
    }
    
}

fileprivate extension NSRange {
    
    func offset(_ by: Int) -> NSRange {
        return NSRange.init(location: self.location + by, length: self.length)
    }
    
    static func ==(left: NSRange, right: NSRange) -> Bool {
        return left.location == right.location && left.length == right.length
    }
    
}

extension NSAttributedString {
    
    var builder: AttributedStringBuilder {
        var attributes: [AttributedStringBuilder.Attribute] = []
        
        enumerateAttributes(in: self.string.fullRange, options: []) {
            (attributesBatch, range, _) in
            
            for attribute in attributesBatch {
                attributes.append((attribute.key, attribute.value, range))
            }
        }
        
        return AttributedStringBuilder(base: self.string, attributes: attributes)
    }
    
}

struct AttributedStringBuilder {
    
    fileprivate typealias Attribute = (name: String, value: Any, range: NSRange)
    
    private var base: String
    
    private var attributes: [Attribute]
    
    fileprivate init(base: String, attributes: [Attribute]) {
        self.base = base
        self.attributes = attributes
    }
    
    //MARK: Attribute Addition
    
    func with(underlineStyle: NSUnderlineStyle, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSUnderlineStyleAttributeName, underlineStyle.rawValue, range ?? base.fullRange))
        
        return result
    }
    
    func with(kern: Double, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSKernAttributeName, kern, range ?? base.fullRange))
        
        return result
    }
    
    func with(strikethroughStyle: NSUnderlineStyle, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSStrikethroughStyleAttributeName, strikethroughStyle.rawValue, range ?? base.fullRange))
        
        return result
    }
    
    func with(foregroundColor: UIColor, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSForegroundColorAttributeName, foregroundColor, range ?? base.fullRange))
        
        return result
    }
    
    func with(backgroundColor: UIColor, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSBackgroundColorAttributeName, backgroundColor, range ?? base.fullRange))
        
        return result
    }
    
    func with(font: UIFont, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSFontAttributeName, font, range ?? base.fullRange))
        
        return result
    }
    
    func with(link: NSURL, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSLinkAttributeName, link.absoluteString ?? "", range ?? base.fullRange))
        
        return result
    }
    
    func with(strokeColor: UIColor, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSStrokeColorAttributeName, strokeColor, range ?? base.fullRange))
        
        return result
    }
    
    func with(strokeWidth: CGFloat, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((NSStrokeWidthAttributeName, strokeWidth, range ?? base.fullRange))
        
        return result
    }
    
    //MARK: Attribute removing
    
    func removeUnderlineStyle(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSUnderlineStyleAttributeName, range: range)
    }
    
    func removeKern(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSKernAttributeName, range: range)
    }
    
    func removeStrikethroughStyle(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSStrikethroughStyleAttributeName, range: range)
    }
    
    func removeForegroundColor(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSForegroundColorAttributeName, range: range)
    }
    
    func removeBackgroundColor(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSBackgroundColorAttributeName, range: range)
    }
    
    func removeFont(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSFontAttributeName, range: range)
    }
    
    func removeLink(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSLinkAttributeName, range: range)
    }
    
    func removeStrokeColor(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSStrokeColorAttributeName, range: range)
    }
    
    func removeStrokeWidth(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(name: NSStrokeWidthAttributeName, range: range)
    }
    
    //MARK: String appending
    
    func append(_ image: UIImage, size: CGSize, origin: CGPoint = .zero) -> AttributedStringBuilder {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: origin, size: size)
        
        let string = NSAttributedString(attachment: attachment)
        
        return append(string.builder)
    }
    
    func append(_ other: AttributedStringBuilder) -> AttributedStringBuilder {
        let offset = base.characters.count
        
        let otherAttributes = other.attributes.map({
            (attribute) -> Attribute in
            
            return (attribute.name, attribute.value, attribute.range.offset(offset))
        })
        
        var result = self
        
        result.base.append(other.base)
        result.attributes.append(contentsOf: otherAttributes)
        
        return result
    }
    
    func append(_ string: String) -> AttributedStringBuilder {
        var result = self
        
        result.base.append(string)
        
        return result
    }
    
    func inCase(_ predicate: Bool,
                _ closure: (_ builder: AttributedStringBuilder) -> AttributedStringBuilder) -> AttributedStringBuilder {
        guard predicate else {
            return self
        }
        
        return closure(self)
    }
    
    //MARK: Builder
    
    func build() -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: base)
        
        for attribute in attributes {
            mutable.addAttribute(attribute.name, value: attribute.value, range: attribute.range)
        }
        // swiftlint:disable force_cast
        return mutable.copy() as! NSAttributedString
        // swiftlint:enable force_cast
    }
    
    //MARK: Utils
    
    private func removeAttribute(name: String, range: NSRange? = nil) throws -> AttributedStringBuilder {
        var result = self
        
        guard let validRange = range else {
            throw AttributedStringBuilderError.attributeNotFoundError
        }
        
        let index = result.attributes.index { (attribute: Attribute) -> Bool in
            
            return attribute.name == name && attribute.range == validRange
        }
        
        guard let foundIndex = index else {
            throw AttributedStringBuilderError.attributeNotFoundError
        }
        
        result.attributes.remove(at: foundIndex)
        
        return result
    }
    
}
