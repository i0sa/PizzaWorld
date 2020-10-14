//
//  Observable.swift
//  PizzaWorld
//
//  Created by Osama on 10/14/20.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ onChanged: Listener?){
        listener = onChanged
        onChanged?(value)
    }
}
