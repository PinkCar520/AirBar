//
//  Notification+Extensions.swift
//  AirBar
//
//  Created by 草莓凤梨 on 3/5/25.
//
import Foundation

/// 定义应用程序中使用的自定义通知名称
extension Notification.Name {
    /// AirBar 状态改变时发送的通知
    /// - Note: 此通知在以下情况下发送:
    ///   - 用户手动切换 AirBar 开关状态
    ///   - 应用程序启动时加载保存的状态
    /// - UserInfo keys:
    ///   - "isEnabled": Bool - 表示 AirBar 是否启用
    static let airBarStateChanged = Notification.Name("airBarStateChanged")
}
