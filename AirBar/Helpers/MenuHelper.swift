//
//  MenuHelper.swift
//  AirBar
//
//  Created by 草莓凤梨 on 3/5/25.
//
import Cocoa

/// 菜单辅助工具类，用于创建和管理菜单项
class MenuHelper {
    // MARK: - Menu Item Creation
    
    /// 创建带开关的菜单项
    /// - Parameters:
    ///   - title: 菜单项标题
    ///   - action: 开关触发的动作
    ///   - target: 动作的目标对象
    /// - Returns: 包含开关的视图
    static func createSwitchMenuItem(title: String, 
                                   action: Selector, 
                                   target: AnyObject) -> NSView {
        return SwitchMenuItemView(title: title, 
                                action: action, 
                                target: target)
    }

    // MARK: - Layout Calculations
    
    /// 计算图标网格的高度
    /// - Parameter itemCount: 图标数量
    /// - Returns: 网格高度
    static func calculateGridHeight(for itemCount: Int) -> CGFloat {
        let columnsPerRow = 4
        let rowHeight: CGFloat = 40
        let rowCount = ceil(Double(itemCount) / Double(columnsPerRow))
        return rowCount * rowHeight
    }
}
