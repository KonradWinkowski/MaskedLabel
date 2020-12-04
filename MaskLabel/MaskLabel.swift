//
//  MaskLabel.swift
//  MaskLabel
//
//  Created by Konrad Winkowski on 12/2/20.
//

import UIKit
final class MaskLabel: UILabel {

    struct MaskLabelConfigurstion {
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let borderColor: UIColor
        let backgroundColor: UIColor
        let insetTop: CGFloat
        let insetLeft: CGFloat
        let insetBottom: CGFloat
        let insetRight: CGFloat
    }

    // MARK: - IBInspectoable
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor) }
        set { self.layer.borderColor = newValue.cgColor }
    }

    @IBInspectable var insetTop: CGFloat {
        get { return self.textInsets.top }
        set { self.textInsets.top = newValue }
    }

    @IBInspectable var insetLeft: CGFloat {
        get { return self.textInsets.left }
        set { self.textInsets.left = newValue }
    }

    @IBInspectable var insetBottom: CGFloat {
        get { return self.textInsets.bottom }
        set { self.textInsets.bottom = newValue }
    }

    @IBInspectable var insetRight: CGFloat {
        get { return self.textInsets.right }
        set { self.textInsets.right = newValue }
    }

    private var textInsets = UIEdgeInsets.zero
    private var originalBackgroundColor: UIColor? = nil

    convenience init(with configuration: MaskLabelConfigurstion) {
        self.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setLabelUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLabelUI()
    }

    override func prepareForInterfaceBuilder() {
        setLabelUI()
    }

    // MARK: - Update
    func update(configuration: MaskLabelConfigurstion) {
        backgroundColor = configuration.backgroundColor
        originalBackgroundColor = backgroundColor
        layer.cornerRadius = configuration.cornerRadius
        layer.borderWidth = configuration.borderWidth
        layer.borderColor = configuration.borderColor.cgColor
        textInsets.top = configuration.insetTop
        textInsets.bottom = configuration.insetBottom
        textInsets.left = configuration.insetLeft
        textInsets.right = configuration.insetRight
    }

    // MARK: - Draw
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.saveGState()
        context.setBlendMode(.clear)

        originalBackgroundColor?.setFill()
        UIRectFill(rect)

        super.drawText(in: rect)
        context.restoreGState()
    }


    private func setLabelUI() {
        originalBackgroundColor = backgroundColor
        backgroundColor = .clear

        layer.cornerRadius = cornerRadius
        layer.borderWidth  = borderWidth
        layer.borderColor  = borderColor.cgColor
        layer.masksToBounds = true
    }
}
