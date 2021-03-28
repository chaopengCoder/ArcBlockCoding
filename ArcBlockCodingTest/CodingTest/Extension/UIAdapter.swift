//
//  UIAdapter.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import UIKit

struct UIAdapter {
    /// 屏幕宽度
    static let Width = UIScreen.main.bounds.size.width
    /// 屏幕高度
    static let Height = UIScreen.main.bounds.size.height
    // 状态栏高度
    static let StatusBarHeight: CGFloat = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    
    /// 导航栏高度: 状态栏高度 + 44
    static let NavigationHeight: CGFloat = StatusBarHeight + 44
    
}
