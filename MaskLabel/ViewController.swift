//
//  ViewController.swift
//  MaskLabel
//
//  Created by Konrad Winkowski on 12/2/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var maskLabel: MaskLabel!
    @IBOutlet weak var inputTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(Self.didTapView)))
        maskLabel.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(Self.didTapToEdit)))

        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(Self.handlePanGesture(panGesture:)))
        maskLabel.addGestureRecognizer(panGesture)
    }
    @IBAction func didTapUpdate(_ sender: Any) {
        let backrounds: [UIColor] = [UIColor.black.withAlphaComponent(0.5),
                                     UIColor.red.withAlphaComponent(0.8),
                                     UIColor.green.withAlphaComponent(0.3),
                                     UIColor.blue.withAlphaComponent(0.7)]
        let radiuses: [CGFloat] = [2, 5, 12, 30]
        let borders: [UIColor] = [UIColor.blue, UIColor.black, UIColor.green]
        let widths: [CGFloat] = [0.5, 1, 2, 5, 10]
        let insets: [CGFloat] = [4, 8 , 16, 22]
        let config = MaskLabel.MaskLabelConfigurstion(cornerRadius: radiuses.randomElement()!,
                                                      borderWidth: widths.randomElement()!,
                                                      borderColor: borders.randomElement()!,
                                                      backgroundColor: backrounds.randomElement()!,
                                                      insetTop: insets.randomElement()!,
                                                      insetLeft: insets.randomElement()!,
                                                      insetBottom: insets.randomElement()!,
                                                      insetRight: insets.randomElement()!)
        maskLabel.update(configuration: config)
    }

    @objc private func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        panGesture.setTranslation(.zero, in: view)

        guard let label = panGesture.view else { return }
        label.center = CGPoint(x: label.center.x+translation.x, y: label.center.y+translation.y)
        label.isMultipleTouchEnabled = true
        label.isUserInteractionEnabled = true

        switch panGesture.state {
        case .began:
            break
        case .ended, .cancelled:
            break
        case .changed:
            break
        default:
            break
        }
    }

    @objc private func didTapToEdit() {
        inputTextView.becomeFirstResponder()
    }

    @objc private func didTapView() {
        inputTextView.resignFirstResponder()
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        maskLabel.text = textView.text
        // TODO: this logic should be cleaned up
        let fontAttributes = [NSAttributedString.Key.font: maskLabel.font]
        let size = (maskLabel.text! as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
        var labelFrame = maskLabel.frame
        labelFrame.size.width = size.width
        labelFrame.size.height = size.height
        maskLabel.frame = labelFrame
    }
}

