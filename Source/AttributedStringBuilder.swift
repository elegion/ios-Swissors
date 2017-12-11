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

public extension String {
    
    /**
     Used to access attributed string builder
     
     Example:
     ```
     "test string"
        .attribute
        .with(strokeColor: .red)
        .build()
     ```
    */
    
    public var attribute: AttributedStringBuilder {
        return AttributedStringBuilder(base: self, attributes: [])
    }
    
    fileprivate var fullRange: NSRange {
        return NSRange(location: 0, length: count)
    }
    
}

public extension NSAttributedString {
    
    /**
     Used to access attributed string builder
     
     Example:
     ```
     "test string"
        .attribute
        .with(strokeColor: .red)
        .build()
        .sw_builder
        .with(kern: 2.0)
        .build()
     ```
     */
    
    public var sw_builder: AttributedStringBuilder {
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

public struct AttributedStringBuilder {
    
    public typealias Attribute = (key: NSAttributedStringKey, value: Any, range: NSRange)
    
    private var base: String
    
    public var attributes: [Attribute]
    
    fileprivate init(base: String, attributes: [Attribute]) {
        self.base = base
        self.attributes = attributes
    }
    
    //MARK: - Builder
    
    /**
     Builds attributed string with stored attributes and base plain string.
     
     - returns:
     Built attributed string.
     */
    public func build() -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: base)
        
        for attribute in attributes {
            mutable.addAttribute(attribute.key, value: attribute.value, range: attribute.range)
        }
        // swiftlint:disable force_cast
        return mutable.copy() as! NSAttributedString
        // swiftlint:enable force_cast
    }
    
    /**
     Applies attributes from closure when predicate is true.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - predicate: Condition when attributes should be applied.
        - closure: Closure where attributes will be applied.
     
     Don't forget about calling build() function after all attributes are set.
     
     Example:
     ```
     "test string"
        .attribute
        .with(kern: 5)
        .with(backgroundColor: .red)
        .inCase(true, {
            $0.append("text string")
        })
        .build()
     ```
     */
    
    public func inCase(_ predicate: Bool,
                       _ closure: (_ builder: AttributedStringBuilder) -> AttributedStringBuilder) -> AttributedStringBuilder {
        guard predicate else {
            return self
        }
        
        return closure(self)
    }
    
}

//MARK: - Attribute Addition

extension AttributedStringBuilder {
    
    /**
     Adds underline style attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - underlineStyle: Style attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(underlineStyle: NSUnderlineStyle, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.underlineStyle, underlineStyle.rawValue, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds kern attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - kern: Value of kern attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(kern: Double, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.kern, kern, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds strikethrough style attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - strikethroughStyle: Style attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(strikethroughStyle: NSUnderlineStyle, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.strikethroughStyle, strikethroughStyle.rawValue, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds foreground color attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - foregroundColor: Color attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(foregroundColor: UIColor, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.foregroundColor, foregroundColor, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds background color attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - backgroundColor: Color attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(backgroundColor: UIColor, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.backgroundColor, backgroundColor, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds font attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - font: Font attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(font: UIFont, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.font, font, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds link attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - link: URL to link with text. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(link: NSURL, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.link, link.absoluteString ?? "", range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds stroke color attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - strokeColor: Color attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(strokeColor: UIColor, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.strokeColor, strokeColor, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds stroke width attribute to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - strokeWidth: Stroke width attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(strokeWidth: CGFloat, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.strokeWidth, strokeWidth, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds paragraph style to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - paragraphStyle: Paragraph style attribute. Required parameter.
        - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func with(paragraphStyle: NSParagraphStyle, range: NSRange? = nil) -> AttributedStringBuilder {
        var result = self
        
        result.attributes.append((.paragraphStyle, paragraphStyle, range ?? base.fullRange))
        
        return result
    }
    
    /**
     Adds paragraph style with your own properties to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
     - all properties of NSMutableParagraphStyle
     - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    public func withParagraphStyle(with lineSpacing: CGFloat? = nil,
                                   paragraphSpacing: CGFloat? = nil,
                                   alignment: NSTextAlignment? = nil,
                                   firstLineHeadIndent: CGFloat? = nil,
                                   headIndent: CGFloat? = nil,
                                   tailIndent: CGFloat? = nil,
                                   lineBreakMode: NSLineBreakMode? = nil,
                                   minimumLineHeight: CGFloat? = nil,
                                   maximumLineHeight: CGFloat? = nil,
                                   baseWritingDirection: NSWritingDirection? = nil,
                                   lineHeightMultiple: CGFloat? = nil,
                                   paragraphSpacingBefore: CGFloat? = nil,
                                   hyphenationFactor: Float? = nil,
                                   tabStops: [NSTextTab]? = nil,
                                   defaultTabInterval: CGFloat? = nil,
                                   range: NSRange? = nil) -> AttributedStringBuilder {
        
        let resultParagraphStyle = paragraphStyle(with: lineSpacing,
                                                  paragraphSpacing: paragraphSpacing,
                                                  alignment: alignment,
                                                  firstLineHeadIndent: firstLineHeadIndent,
                                                  headIndent: headIndent,
                                                  tailIndent: tailIndent,
                                                  lineBreakMode: lineBreakMode,
                                                  minimumLineHeight: minimumLineHeight,
                                                  maximumLineHeight: maximumLineHeight,
                                                  baseWritingDirection: baseWritingDirection,
                                                  lineHeightMultiple: lineHeightMultiple,
                                                  paragraphSpacingBefore: paragraphSpacing,
                                                  hyphenationFactor: hyphenationFactor,
                                                  tabStops: tabStops,
                                                  defaultTabInterval: defaultTabInterval,
                                                  range: range)
        
        return with(paragraphStyle: resultParagraphStyle)
    }
    
    /**
     Adds paragraph style with your own properties to attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
     - all properties of NSMutableParagraphStyle
     - range: Range on which attribute will be applied. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    @available (iOS 9.0, *)
    public func withParagraphStyle(with lineSpacing: CGFloat? = nil,
                                   paragraphSpacing: CGFloat? = nil,
                                   alignment: NSTextAlignment? = nil,
                                   firstLineHeadIndent: CGFloat? = nil,
                                   headIndent: CGFloat? = nil,
                                   tailIndent: CGFloat? = nil,
                                   lineBreakMode: NSLineBreakMode? = nil,
                                   minimumLineHeight: CGFloat? = nil,
                                   maximumLineHeight: CGFloat? = nil,
                                   baseWritingDirection: NSWritingDirection? = nil,
                                   lineHeightMultiple: CGFloat? = nil,
                                   paragraphSpacingBefore: CGFloat? = nil,
                                   hyphenationFactor: Float? = nil,
                                   tabStops: [NSTextTab]? = nil,
                                   defaultTabInterval: CGFloat? = nil,
                                   allowsDefaultTighteningForTruncation: Bool? = nil,
                                   range: NSRange? = nil) -> AttributedStringBuilder {
        
        let resultParagraphStyle = paragraphStyle(with: lineSpacing,
                                                  paragraphSpacing: paragraphSpacing,
                                                  alignment: alignment,
                                                  firstLineHeadIndent: firstLineHeadIndent,
                                                  headIndent: headIndent,
                                                  tailIndent: tailIndent,
                                                  lineBreakMode: lineBreakMode,
                                                  minimumLineHeight: minimumLineHeight,
                                                  maximumLineHeight: maximumLineHeight,
                                                  baseWritingDirection: baseWritingDirection,
                                                  lineHeightMultiple: lineHeightMultiple,
                                                  paragraphSpacingBefore: paragraphSpacing,
                                                  hyphenationFactor: hyphenationFactor,
                                                  tabStops: tabStops,
                                                  defaultTabInterval: defaultTabInterval,
                                                  allowsDefaultTighteningForTruncation: allowsDefaultTighteningForTruncation,
                                                  range: range)
        
        return with(paragraphStyle: resultParagraphStyle)
    }
    
}

//MARK: - Attribute removing

extension AttributedStringBuilder {
    
    /**
     Remove underline style attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeUnderlineStyle(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .underlineStyle, in: range)
    }
    
    /**
     Remove kern attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeKern(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .kern, in: range)
    }
    
    /**
     Remove strikethrough style attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeStrikethroughStyle(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .strikethroughStyle, in: range)
    }
    
    /**
     Remove foreground color attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeForegroundColor(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .foregroundColor, in: range)
    }
    
    /**
     Remove background color attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeBackgroundColor(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .backgroundColor, in: range)
    }
    
    /**
     Remove font attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeFont(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .font, in: range)
    }
    
    /**
     Remove link attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeLink(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .link, in: range)
    }
    
    /**
     Remove stroke color attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeStrokeColor(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .strokeColor, in: range)
    }
    
    /**
     Remove stroke width attribute from attrubutes array of string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - throws:
     An error of type `AttributedStringBuilderError`
     
     - parameters:
        - range: Range on which attribute will be removed. Optional parameter. Defaults to full range.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func removeStrokeWidth(range: NSRange? = nil) throws -> AttributedStringBuilder {
        return try removeAttribute(for: .strokeWidth, in: range)
    }
    
    private func removeAttribute(for key: NSAttributedStringKey, in range: NSRange? = nil) throws -> AttributedStringBuilder {
        var result = self
        
        guard let validRange = range else {
            throw AttributedStringBuilderError.attributeNotFoundError
        }
        
        let index = result.attributes.index {
            (attribute: Attribute) -> Bool in
            
            return attribute.key == key && attribute.range == validRange
        }
        
        guard let foundIndex = index else {
            throw AttributedStringBuilderError.attributeNotFoundError
        }
        
        result.attributes.remove(at: foundIndex)
        
        return result
    }
    
}

//MARK: - String appending

extension AttributedStringBuilder {
    
    /**
     Appends image to attributed string as text attachment
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - image: Image which be appended. Required parameter
        - size: Size of image. Optional parameter. Defaults to image.size.
        - origin: Origin of image. Optional parameter. Defaults to CGPoint.zero
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func append(_ image: UIImage, size: CGSize?, origin: CGPoint = .zero) -> AttributedStringBuilder {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: origin, size: size ?? image.size)
        
        let string = NSAttributedString(attachment: attachment)
        
        return append(string.sw_builder)
    }
    
    /**
     Appends attributed string builder of other string to append.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - other: Attributed string bulder of other string to append.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func append(_ other: AttributedStringBuilder) -> AttributedStringBuilder {
        let offset = base.count
        
        let otherAttributes = other.attributes.map({
            (attribute) -> Attribute in
            
            return (attribute.key, attribute.value, attribute.range.sw_offset(by: offset))
        })
        
        var result = self
        
        result.base.append(other.base)
        result.attributes.append(contentsOf: otherAttributes)
        
        return result
    }
    
    /**
     Appends string to attributed string builder.
     
     - returns:
     Attributed string builder with modified attributes array.
     
     - parameters:
        - string: String to append.
     
     Don't forget about calling build() function after all attributes are set.
     */
    
    public func append(_ string: String) -> AttributedStringBuilder {
        var result = self
        
        result.base.append(string)
        
        return result
    }
    
    //MARK: - Private
    
    private func paragraphStyle(with lineSpacing: CGFloat? = nil,
                                paragraphSpacing: CGFloat? = nil,
                                alignment: NSTextAlignment? = nil,
                                firstLineHeadIndent: CGFloat? = nil,
                                headIndent: CGFloat? = nil,
                                tailIndent: CGFloat? = nil,
                                lineBreakMode: NSLineBreakMode? = nil,
                                minimumLineHeight: CGFloat? = nil,
                                maximumLineHeight: CGFloat? = nil,
                                baseWritingDirection: NSWritingDirection? = nil,
                                lineHeightMultiple: CGFloat? = nil,
                                paragraphSpacingBefore: CGFloat? = nil,
                                hyphenationFactor: Float? = nil,
                                tabStops: [NSTextTab]? = nil,
                                defaultTabInterval: CGFloat? = nil,
                                range: NSRange? = nil) -> NSMutableParagraphStyle {
        let resultParagraphStyle = NSMutableParagraphStyle()
        
        resultParagraphStyle.lineSpacing = lineSpacing ?? resultParagraphStyle.lineSpacing
        resultParagraphStyle.paragraphSpacing = paragraphSpacing ?? resultParagraphStyle.paragraphSpacing
        resultParagraphStyle.alignment = alignment ?? resultParagraphStyle.alignment
        resultParagraphStyle.firstLineHeadIndent = firstLineHeadIndent ?? resultParagraphStyle.firstLineHeadIndent
        resultParagraphStyle.headIndent = headIndent ?? resultParagraphStyle.headIndent
        resultParagraphStyle.tailIndent = tailIndent ?? resultParagraphStyle.tailIndent
        resultParagraphStyle.lineBreakMode = lineBreakMode ?? resultParagraphStyle.lineBreakMode
        resultParagraphStyle.minimumLineHeight = minimumLineHeight ?? resultParagraphStyle.minimumLineHeight
        resultParagraphStyle.maximumLineHeight = maximumLineHeight ?? resultParagraphStyle.maximumLineHeight
        resultParagraphStyle.baseWritingDirection = baseWritingDirection ?? resultParagraphStyle.baseWritingDirection
        resultParagraphStyle.lineHeightMultiple = lineHeightMultiple ?? resultParagraphStyle.lineHeightMultiple
        resultParagraphStyle.paragraphSpacingBefore = paragraphSpacingBefore ?? resultParagraphStyle.paragraphSpacingBefore
        resultParagraphStyle.hyphenationFactor = hyphenationFactor ?? resultParagraphStyle.hyphenationFactor
        resultParagraphStyle.tabStops = tabStops ?? resultParagraphStyle.tabStops
        resultParagraphStyle.defaultTabInterval = defaultTabInterval ?? resultParagraphStyle.defaultTabInterval
        
        return resultParagraphStyle
    }
    
    @available (iOS 9.0, *)
    private func paragraphStyle(with lineSpacing: CGFloat? = nil,
                                paragraphSpacing: CGFloat? = nil,
                                alignment: NSTextAlignment? = nil,
                                firstLineHeadIndent: CGFloat? = nil,
                                headIndent: CGFloat? = nil,
                                tailIndent: CGFloat? = nil,
                                lineBreakMode: NSLineBreakMode? = nil,
                                minimumLineHeight: CGFloat? = nil,
                                maximumLineHeight: CGFloat? = nil,
                                baseWritingDirection: NSWritingDirection? = nil,
                                lineHeightMultiple: CGFloat? = nil,
                                paragraphSpacingBefore: CGFloat? = nil,
                                hyphenationFactor: Float? = nil,
                                tabStops: [NSTextTab]? = nil,
                                defaultTabInterval: CGFloat? = nil,
                                allowsDefaultTighteningForTruncation: Bool? = nil,
                                range: NSRange? = nil) -> NSMutableParagraphStyle {
        
        let resultParagraphStyle = paragraphStyle(with: lineSpacing,
                                                  paragraphSpacing: paragraphSpacing,
                                                  alignment: alignment,
                                                  firstLineHeadIndent: firstLineHeadIndent,
                                                  headIndent: headIndent,
                                                  tailIndent: tailIndent,
                                                  lineBreakMode: lineBreakMode,
                                                  minimumLineHeight: minimumLineHeight,
                                                  maximumLineHeight: maximumLineHeight,
                                                  baseWritingDirection: baseWritingDirection,
                                                  lineHeightMultiple: lineHeightMultiple,
                                                  paragraphSpacingBefore: paragraphSpacing,
                                                  hyphenationFactor: hyphenationFactor,
                                                  tabStops: tabStops,
                                                  defaultTabInterval: defaultTabInterval,
                                                  range: range)
        
        resultParagraphStyle.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation ?? resultParagraphStyle.allowsDefaultTighteningForTruncation
        
        return resultParagraphStyle
    }
    
}
