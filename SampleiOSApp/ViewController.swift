//
//  ViewController.swift
//  SampleiOSApp
//
//  Created by Thomas DURAND on 11/06/2019.
//

import RecordingOverlay
import UIKit

class ViewController: UIViewController {

    var overlay: UIWindow?
    var subview: UIView?

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addSubviewButton: UIButton!
    @IBOutlet weak var changeColorButton: UIButton!
    @IBOutlet weak var changeSizeButton: UIButton!
    @IBOutlet weak var toggleAnimationButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!

    var overlayRelatedButtons: [UIButton] {
        return [changeColorButton, addSubviewButton, changeSizeButton, toggleAnimationButton, removeButton]
    }

    let colors: [UIColor] = [.red, .green, .blue, .orange, .magenta, .purple]
    var currentColorIndex = 0

    let sizes: [CGFloat] = [3, 6, 9]
    var currentSizeIndex = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overlayRelatedButtons.forEach { $0.isEnabled = false }
    }

    @IBAction func addOverlay() {
        self.overlay = RecordingOverlay.add()

        addButton.isEnabled = false
        overlayRelatedButtons.forEach { $0.isEnabled = true }
        setNeedsFocusUpdate()
    }

    @IBAction func addSubview() {

        let button = UIButton()
        button.setTitle("Remove subview", for: .normal)
        button.backgroundColor = .gray
        button.sizeToFit()
        button.center.x = overlay?.center.x ?? 0
        button.frame.origin.y = 20
        overlay?.addSubview(button)
        self.subview = button

        button.addTarget(self, action: #selector(self.removeSubview), for: .touchUpInside)

        // Only one subview at a time
        addSubviewButton.isEnabled = false
    }

    @objc func removeSubview() {
        self.subview?.removeFromSuperview()
        addSubviewButton.isEnabled = true
    }

    @IBAction func toggleAnimations() {
        RecordingOverlay.isAnimated = !RecordingOverlay.isAnimated
        toggleAnimationButton.setTitle(RecordingOverlay.isAnimated ? "Disable animation" : "Enable animation", for: .normal)
    }

    @IBAction func changeColor() {
        currentColorIndex += 1
        currentColorIndex %= colors.count
        RecordingOverlay.color = colors[currentColorIndex]
    }

    @IBAction func changeSize() {
        currentSizeIndex += 1
        currentSizeIndex %= sizes.count
        RecordingOverlay.length = sizes[currentSizeIndex]
    }

    @IBAction func removeOverlay() {
        RecordingOverlay.remove()

        addButton.isEnabled = true
        overlayRelatedButtons.forEach { $0.isEnabled = false }
        setNeedsFocusUpdate()
    }
}
