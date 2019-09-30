//
//  ViewController.swift
//  RestApiLayerDemo
//
//  Created by Владислав Терновский on 9/30/19.
//  Copyright © 2019 Vladyslav Ternovskyi. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let network = DefaultNetwork()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.request(target: RestAPI.Profile.getProfile)
            .map(User.self)
            .subscribe(onSuccess: { user in
                print(user)
            }, onError: { error in
                print(error)
            })
            .disposed(by: bag)
    }


}

