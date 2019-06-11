//
//  ViewController.swift
//  SampleApp
//
//  Created by Thomas DURAND on 09/06/2019.
//  Copyright © 2019 Thomas DURAND. All rights reserved.
//

import RecordingOverlay
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var changeColorButton: UIButton!
    @IBOutlet weak var changeSizeButton: UIButton!
    @IBOutlet weak var toggleAnimationButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!

    var overlayRelatedButtons: [UIButton] {
        return [changeColorButton, changeSizeButton, toggleAnimationButton, removeButton]
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
        RecordingOverlay.add()

        addButton.isEnabled = false
        overlayRelatedButtons.forEach { $0.isEnabled = true }
        setNeedsFocusUpdate()
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