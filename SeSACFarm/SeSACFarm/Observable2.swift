//
//  Observable2.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/03.
//

//Rx를 적용하니까 Observalbe 클래스명이 겹쳐서 급하게 바꾼 상태
import Foundation

class Observable2<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
