//
//  PermissionsManager.swift
//  AirBar
//
//  Created by 草莓凤梨 on 3/5/25.
//
import Cocoa
import ApplicationServices

class PermissionsManager {
    /// 检查是否已授予辅助功能权限
    static func isAccessibilityPermissionGranted() -> Bool {
        return AXIsProcessTrusted()
    }

    /// 申请权限，如果未授权，则弹窗引导用户手动开启
    static func requestAccessibilityPermission() {
        if !isAccessibilityPermissionGranted() {
            let alert = NSAlert()
            alert.messageText = "需要辅助功能权限"
            alert.informativeText = "AirBar 需要访问系统状态栏图标，请前往“系统设置” → “辅助功能”手动开启权限。"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "打开系统设置")
            alert.addButton(withTitle: "取消")

            let response = alert.runModal()
            if response == .alertFirstButtonReturn {
                openAccessibilitySettings()
            }
        }
    }

    /// 打开 macOS “系统设置” → “辅助功能”页面
    static func openAccessibilitySettings() {
        let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!
        NSWorkspace.shared.open(url)
    }
}
