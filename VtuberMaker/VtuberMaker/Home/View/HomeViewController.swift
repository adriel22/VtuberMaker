//
//  HomeViewController.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 08/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: HomeViewModel
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()

    }

    private func configureTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(type: AvatarTableViewCell.self)
        tableView.registerReusableHeaderFooter(type: AddAvatarTableFooterView.self)
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getSavedModels().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeue(withType: AvatarTableViewCell.self, for: indexPath) { cell in
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooter(withType: AddAvatarTableFooterView.self) { footer in
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.routeToModel(viewModel.getSavedModels()[indexPath.row])
    }
    
}

fileprivate struct Constants {
    static let cellHeight: CGFloat = 146
}
