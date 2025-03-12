//
//  IconsGridView.swift
//  AirBar
//
//  Created by 草莓凤梨 on 3/5/25.
//
import SwiftUI

/// 图标网格视图，用于显示系统图标列表
struct IconsGridView: View {
    // MARK: - Properties
    
    /// 要显示的系统图标名称数组
    let systemIcons: [String]
    /// 包含此视图的菜单
    let parentMenu: NSMenu
    /// 父菜单项
    let parentMenuItem: NSMenuItem
    
    /// 网格列配置
    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: Constants.iconSpacing), count: Constants.columnsCount)
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let headerHeight: CGFloat = 35
        static let gridWidth: CGFloat = 180
        static let iconSize: CGFloat = 22
        static let iconSpacing: CGFloat = 10
        static let columnsCount: Int = 4
        static let rowHeight: CGFloat = 40
    }

    // MARK: - Body
    
    var body: some View {
        VStack {
            // 标题部分
            HStack {
                Text("Show App")
                    .font(.system(size: 14))
                Spacer()
            }
            .frame(height: Constants.headerHeight)
            .padding(.horizontal, 5)
            
            // 图标网格
            LazyVGrid(columns: gridColumns, spacing: Constants.iconSpacing) {
                ForEach(systemIcons, id: \.self) { iconName in
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.iconSize, height: Constants.iconSize)
                }
            }
            .frame(height: calculateGridHeight())
        }
        .frame(width: Constants.gridWidth)
        .background(GeometryReader { geometry in
            Color.clear
                .onAppear {
                    updateParentMenuSize(to: geometry.size.height)
                }
                .onChange(of: systemIcons.count) {
                    updateParentMenuSize(to: geometry.size.height)
                }
        })
    }
    
    // MARK: - Helper Methods
    
    /// 计算网格内容的总高度
    private func calculateGridHeight() -> CGFloat {
        let rowCount = ceil(Double(systemIcons.count) / Double(Constants.columnsCount))
        return rowCount * Constants.rowHeight
    }
    
    /// 更新父菜单项的大小
    private func updateParentMenuSize(to height: CGFloat) {
        DispatchQueue.main.async {
            parentMenuItem.view?.frame.size.height = height
            parentMenu.update()
        }
    }
}
