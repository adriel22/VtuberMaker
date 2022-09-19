//
//  AvatarSceneViewController.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 16/08/22.
//

import UIKit

class AvatarSceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(withModel: AvatarModel) {
        super.init(nibName: "AvatarSceneViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
