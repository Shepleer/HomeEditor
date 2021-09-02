//
//  ProjectsListViewController .swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

class ProjectsListViewController: UIViewController {
    struct Appearance {
        static let navigationBarTitle = "Projects"
        static let cellReuseIdentifier = "projectCell"
    }
    
    var presenter: ProjectsListViewToPresenterProtocol?
    
    var dataSource: [Project] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var errorView: ErrorPlaceholderView = {
        let errorView = ErrorPlaceholderView(withErrorText: "Parsing error")
        
        return errorView
    }()
    
    private lazy var loadingView: LoadingView = .init(withLoaderText: "Loading..")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupAppearance()
        presenter?.viewDidLoad()
    }
}

extension ProjectsListViewController: ProjectsListPresenterToViewProtocol {
    func update(_ state: LoadingState) {
        switch state {
            case .done:
                focus(on: tableView)
                loadingView.stopAnimating()
            case .loading:
                loadingView.startAnimating()
                focus(on: loadingView)
            case .error(let errorText):
                errorView.setTitle(errorText)
                loadingView.stopAnimating()
                focus(on: errorView)
        }
    }
    
    func update(_ dataSource: [Project]) {
        self.dataSource = dataSource
    }
}

extension ProjectsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Appearance.cellReuseIdentifier)
        let model = dataSource[indexPath.row]
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension ProjectsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cell(didTappedAt: indexPath)
    }
}

private extension ProjectsListViewController {
    func configureNavigationBar() {
        navigationItem.title = Appearance.navigationBarTitle
    }
    
    func setupAppearance() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.widthAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
    }
    
    func focus(on view: UIView) {
        errorView.isHidden = view != errorView
        loadingView.isHidden = view != loadingView
        tableView.isHidden = view != tableView
        
        if self.view.contains(view) {
            self.view.bringSubviewToFront(view)
        }
    }
}
