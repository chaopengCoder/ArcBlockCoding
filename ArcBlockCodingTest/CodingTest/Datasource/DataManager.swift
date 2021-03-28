//
//  DataManager.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import RxSwift
import Foundation
import ObjectMapper

class DataManager {
    
    static let shared = DataManager()
    
    func reload() -> Observable<[MainModel]> {
        guard let path = Bundle.main.path(forResource: "JsonData", ofType: "json") else { return Observable.just([]) }
        
        let url = URL(fileURLWithPath: path)
        
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else { return Observable.just([]) }
            let model = Mapper<BaseModel>().map(JSON: jsonData)
            
            guard let arr = Mapper<MainModel>().mapArray(JSONObject: model?.data) else {
                return Observable.just([])
            }
            
            return Observable.just(arr)
        } catch {
            print(error)
        }
        return Observable.just([])
    }
}
