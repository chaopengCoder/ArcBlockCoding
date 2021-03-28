//
//  MainViewModel.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/27.
//

import RxSwift
import RxCocoa
import Foundation

class MainViewModel {
    fileprivate let disposeBag = DisposeBag()
    
    /// 列表数据信号
    let listData = BehaviorRelay<[MainModel]>(value: [])
    
    // 加载数据
    func loadList(){
        DataManager.shared.reload()
            .do(onNext: { (models) in
             print(models)
            })
            .bind(to: listData)
            .disposed(by: disposeBag)
    }
    
}
