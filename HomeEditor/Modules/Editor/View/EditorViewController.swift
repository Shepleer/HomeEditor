//
//  EditorViewController.swift
//  HomeEditor
//
//  Created by Ivan Shepler on 02/09/2021.
//

import UIKit

class EditorViewController: UIViewController {
    
    var presenter: EditorViewToPresenterProtocol?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .black
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
        return scrollView
    }()
    
    lazy var editorView: EditorView = {
        let editorView = EditorView(frame: scrollView.bounds)
        editorView.backgroundColor = .black
        return editorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        presenter?.viewDidLoad()
    }
}

extension EditorViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        editorView
    }
}

extension EditorViewController: EditorPresenterToViewProtocol {
    func configure(project: Project) {
        editorView.configure(project: project)
    }
}

private extension EditorViewController {
    func setupAppearance() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(editorView)
        editorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editorView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            editorView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            editorView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            editorView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
