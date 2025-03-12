//
//  SwitchMenuItemView.swift
//  AirBar
//
//  Created by 草莓凤梨 on 3/5/25.
//

import Cocoa

class SwitchMenuItemView: NSView {
    init(title: String, action: Selector, target: AnyObject) {
        super.init(frame: NSRect(x: 0, y: 0, width: 200, height: 30))
        let label = NSTextField(labelWithString: title)
        label.frame = NSRect(x: 10, y: 5, width: 100, height: 20)

        let toggleSwitch = NSSwitch(frame: NSRect(x: 140, y: 5, width: 50, height: 20))
        toggleSwitch.state = .off
        toggleSwitch.target = target
        toggleSwitch.action = action

        addSubview(label)
        addSubview(toggleSwitch)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
