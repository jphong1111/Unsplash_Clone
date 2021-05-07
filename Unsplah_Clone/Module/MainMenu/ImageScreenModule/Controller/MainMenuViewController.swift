//
//  MainMenuViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet private weak var tableview: UITableView! {
        didSet {
            self.tableview.dataSource = self
            self.tableview.delegate = self
            self.tableview.reloadData()
            self.tableview.register(UINib(nibName: MainMenuTableViewFirstCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: MainMenuTableViewFirstCell.cellIdentifier)
            self.tableview.register(UINib(nibName: MainMenuTableViewSecondCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: MainMenuTableViewSecondCell.cellIdentifier)
        }
    }
    var viewModel: MainMenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension MainMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let centerLabelCell = tableView.dequeueReusableCell(withIdentifier: MainMenuTableViewFirstCell.cellIdentifier, for: indexPath) as? MainMenuTableViewFirstCell else {
            fatalError("Unable to dequeue the centerLabelCell")
        }
        guard let leftLabelCell = tableView.dequeueReusableCell(withIdentifier: MainMenuTableViewSecondCell.cellIdentifier, for: indexPath) as? MainMenuTableViewSecondCell else {
            fatalError("Unable to dequeue the leftLabelCell")
        }
        return centerLabelCell
    }
}
extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
