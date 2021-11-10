//
//  ViewController.swift
//  RefBadges
//
//  Created by Alexander Rinass on 08.11.21.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var stackView: NSStackView?
    var labels: [NSTextField] = []
    var moreLabel: NSTextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView?.orientation = .horizontal
//        stackView?.alignment = .centerY
        stackView?.distribution = .gravityAreas
        stackView?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView?.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stackView?.setClippingResistancePriority(.dragThatCannotResizeWindow, for: .horizontal)
        stackView?.setHuggingPriority(.defaultLow, for: .horizontal)
        stackView?.detachesHiddenViews = true
        stackView?.delegate = self
//        stackView?.wantsLayer = true
//        stackView?.layer?.backgroundColor = NSColor.systemGray.cgColor

        var label: NSTextField

        label = NSTextField(badgeWithTitle: "main", color: .systemBlue)
        label.setContentCompressionResistancePriority(.defaultLow + 50, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold - 5, for: label)

        label = NSTextField(badgeWithTitle: "next", color: .systemBlue)
        label.setContentCompressionResistancePriority(.defaultLow + 49, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold - 10, for: label)

        label = NSTextField(badgeWithTitle: "feature/branches-view", color: .systemBlue)
        label.setContentCompressionResistancePriority(.defaultLow + 44, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold - 18, for: label)

        label = NSTextField(badgeWithTitle: "origin/main", color: .systemMint)
        label.setContentCompressionResistancePriority(.defaultLow + 40, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold - 20, for: label)

        label = NSTextField(badgeWithTitle: "origin/next", color: .systemMint)
        label.setContentCompressionResistancePriority(.defaultLow + 35, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold - 25, for: label)

        label = NSTextField(badgeWithTitle: "tower3-294", color: .systemYellow)
        label.setContentCompressionResistancePriority(.defaultLow + 45, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold - 17, for: label)

        label = NSTextField(badgeWithTitle: "...", color: .systemIndigo)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        labels.append(label)
        stackView?.addView(label, in: .leading)
        stackView?.setVisibilityPriority(.mustHold, for: label)
        label.isHidden = true
        moreLabel = label
    }
}

extension NSTextField {
    convenience init(badgeWithTitle title: String, color: NSColor) {
        self.init(labelWithString: title)
        identifier = NSUserInterfaceItemIdentifier(title)
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        drawsBackground = true
        backgroundColor = color
        lineBreakMode = .byTruncatingMiddle
        let width = max(ceil(attributedStringValue.size().width) * 0.5, 50)
        print(title, width, ceil(attributedStringValue.size().width))
        let c = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        c.priority = .defaultHigh - 10
        c.isActive = true
    }
}

extension ViewController: NSStackViewDelegate {
    func stackView(_ stackView: NSStackView, willDetach views: [NSView]) {
        print("willDetach", views.map({ v in
            v.identifier?.rawValue
        }))

        if let moreLabel = moreLabel {
            if !views.contains(moreLabel) {
                moreLabel.isHidden = false
            }
        }
    }

    func stackView(_ stackView: NSStackView, didReattach views: [NSView]) {
        print("didReattach", views.map({ v in
            v.identifier?.rawValue
        }))
        print("detached:", stackView.detachedViews.count)

        if let moreLabel = moreLabel {
            if !views.contains(moreLabel) {
                if stackView.detachedViews.count == 0 {
                    moreLabel.isHidden = true
                }
            }
        }
    }
}

