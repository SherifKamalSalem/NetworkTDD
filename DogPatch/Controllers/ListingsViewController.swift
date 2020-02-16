//  Created by Sherif Kamal on 02/02/20.
//  Copyright © 2020 Sherif Kamal. All rights reserved.

import UIKit

class ListingsViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.register(ErrorTableViewCell.nib,
                         forCellReuseIdentifier: ErrorTableViewCell.identifier)
    }
  }
  
  // MARK: - Instance Properties
  var viewModels: [DogViewModel] = []
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupRefreshControl()
  }
  
  private func setupRefreshControl() {
    let refreshControl = UIRefreshControl()
    tableView.refreshControl = refreshControl
    
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refreshData()
  }
  
  // MARK: - Refresh
  @objc func refreshData() {
    // TODO: - Write this
  }
}

// MARK: - UITableViewDataSource
extension ListingsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    guard !tableView.refreshControl!.isRefreshing  else {
      return 0
    }
    return max(viewModels.count, 1)
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard viewModels.count > 0 else {
      return errorCell(tableView, indexPath)
    }
    return listingCell(tableView, indexPath)
  }
  
  private func errorCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath)
  }
  
  private func listingCell(_ tableView: UITableView, _ indexPath: IndexPath) -> ListingTableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.identifier) as! ListingTableViewCell
    let viewModel = viewModels[indexPath.row]
    viewModel.configure(cell)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ListingsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
