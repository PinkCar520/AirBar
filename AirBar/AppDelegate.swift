//
//  AppDelegate.swift
//  AirBar
//
//  Created by 草莓凤梨 on 3/5/25.
//

import Cocoa
import SwiftUI
import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: - Properties
    private var primaryStatusItem: NSStatusItem!          // 主状态栏项
    private var gridMenuItem: NSMenuItem!                 // 图标网格菜单项
    private var statusMenu: NSMenu!                      // 状态栏菜单
    private var hideMenu: NSMenu!                        // 隐藏菜单
    private var hideStatusItem: NSStatusItem?            // 隐藏状态栏项
    private var preferencesWindowController: NSWindowController? // 主窗口
    
    // 添加一个属性来跟踪 AirBar 的启用状态
    private var isAirBarEnabled: Bool = false {
        didSet {
            // 当状态变化时自动更新 UI
            updateStatusBarIcon(isEnabled: isAirBarEnabled)
            gridMenuItem?.isHidden = !isAirBarEnabled
            isAirBarEnabled ? hideStatusBar() : showStatusBar()
            statusMenu?.update()
            print("AirBar \(isAirBarEnabled ? "已启用" : "已禁用")")
        }
    }
    
    // MARK: - Lifecycle
    func applicationDidFinishLaunching(_ notification: Notification) {
        // 先检查权限，如果未授权，则引导用户授权
        PermissionsManager.requestAccessibilityPermission()
        configureStatusBar()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        // 清理资源
    }

    // MARK: - Private Methods
    private func configureStatusBar() {
        configurePrimaryStatusItem()
        configureHideStatusItem()
        configureMenus()
        setupMenuItems()
    }
    
    private func configurePrimaryStatusItem() {
        primaryStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        // 使用属性而不是直接传递布尔值
        updateStatusBarIcon(isEnabled: isAirBarEnabled)
    }
    
    private func configureHideStatusItem() {
        hideStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        hideStatusItem?.button?.image = NSImage(systemSymbolName: "arrow.left", accessibilityDescription: "隐藏")
    }
    
    private func configureMenus() {
        statusMenu = NSMenu()
        hideMenu = NSMenu()
    }
    
    private func setupMenuItems() {
        addToggleMenuItem()
        addGridMenuItem()
        addSettingsMenuItem()
        addQuitMenuItem()
        
        primaryStatusItem.menu = statusMenu
    }
    
    private func addToggleMenuItem() {
        let toggleItem = NSMenuItem()
        toggleItem.view = MenuHelper.createSwitchMenuItem(title: "AirBar",
                                                        action: #selector(handleAirBarToggle(_:)),
                                                        target: self)
        statusMenu.addItem(toggleItem)
        statusMenu.addItem(NSMenuItem.separator())
    }
    
    private func addGridMenuItem() {
        gridMenuItem = NSMenuItem()
        gridMenuItem.view = createIconGridView()
        statusMenu.addItem(gridMenuItem)
        statusMenu.addItem(NSMenuItem.separator())
    }
    private func addSettingsMenuItem() {
        statusMenu.addItem(NSMenuItem(title: "AirBar Settings...",
                                    action: #selector(showPreferences),
                                    keyEquivalent: ","))
        statusMenu.addItem(NSMenuItem.separator())
    }
    
    private func addQuitMenuItem() {
        statusMenu.addItem(NSMenuItem(title: "Quit",
                                    action: #selector(quitApp),
                                    keyEquivalent: "q"))
        statusMenu.addItem(NSMenuItem.separator())
    }
    
    // MARK: - UI Components
    private func createIconGridView() -> NSView {
        let systemIcons = ["mic.fill", "paperplane.fill", "battery.100", "sun.max.fill",
                          "keyboard", "heart.fill", "star.fill", "bolt.fill"]
        
        let hostingView = NSHostingView(rootView: IconsGridView(systemIcons: systemIcons,
                                                                parentMenu: statusMenu,
                                                                parentMenuItem: gridMenuItem))
        hostingView.frame = NSRect(x: 0, y: 0,
                                 width: 200,
                                 height: MenuHelper.calculateGridHeight(for: systemIcons.count))
        return hostingView
    }
    
    // MARK: - Actions
    @objc private func hideStatusBar() {
        hideStatusItem?.length = 10000
    }
    
    @objc private func showStatusBar() {
        hideStatusItem?.length = 20
    }
    
    @objc private func openSystemSettings() {
        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.control")!)
    }
    
    @objc private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    /// 更新状态栏图标颜色
    private func updateStatusBarIcon(isEnabled: Bool) {
        let configuration = NSImage.SymbolConfiguration(
            pointSize: 14,
            weight: .regular,
            scale: .medium
        ).applying(
            NSImage.SymbolConfiguration(
                paletteColors: [isEnabled ? NSColor.white.withAlphaComponent(1.0) : NSColor.white.withAlphaComponent(0.45)]
            )
        )
        
        primaryStatusItem?.button?.image = NSImage(
            systemSymbolName: "square.grid.2x2.fill",
            accessibilityDescription: "AirBar"
        )?.withSymbolConfiguration(configuration)
    }
    
    @objc private func handleAirBarToggle(_ sender: NSSwitch) {
        // 只需更新属性，UI 更新将通过属性观察器自动处理
        isAirBarEnabled = sender.state == .on
    }
    
    @objc func showPreferences() {
        if preferencesWindowController == nil {
            let storyboard = NSStoryboard(name: "Main", bundle: nil)
            preferencesWindowController = storyboard.instantiateController(withIdentifier: "PreferencesWindowController") as? NSWindowController
        }
        preferencesWindowController?.showWindow(self)
    }
}



