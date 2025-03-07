import Foundation

/// 管理应用程序的用户偏好设置
/// 使用单例模式确保整个应用程序使用相同的设置实例
final class UserPreferences {
    // MARK: - Singleton
    
    /// 共享实例
    static let shared = UserPreferences()
    
    /// 私有初始化方法确保单例模式
    private init() {}
    
    // MARK: - Constants
    
    /// 用于 UserDefaults 的键名
    private enum Keys {
        /// AirBar 启用状态的存储键
        static let airBarEnabled = "airBarEnabled"
    }
    
    // MARK: - Properties
    
    /// AirBar 的启用状态
    /// - Returns: true 表示启用，false 表示禁用
    /// - Note: 该状态会被自动保存到 UserDefaults
    var isAirBarEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.airBarEnabled)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.airBarEnabled)
        }
    }
    
    // MARK: - Public Methods
    
    /// 设置默认值（如果需要的话可以添加）
    func setupDefaultValues() {
        // 如果将来需要设置默认值，可以在这里实现
    }
}