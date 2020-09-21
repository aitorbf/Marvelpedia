//
//  CharactersViewController.swift
//  Marvelpedia
//
//  Created by Aitor on 16/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

final class CharactersViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var charactersCollectionView: UICollectionView! {
        didSet {
            charactersCollectionView.delegate = self
            charactersCollectionView.dataSource = self
            charactersCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    @IBOutlet weak var emptyCollectionLabel: UILabel!
    
    // MARK: Public variables
    
    var presenter: CharactersPresenterProtocol?
    
    // MARK: - Private constants
    
    private let navigationBarTitle = "Marvelpedia"
    private let cellIdentifier = "characterCell"
    
    // MARK: - Private variables
    
    private var characters = [Character]() {
        didSet {
            emptyCollectionLabel.isHidden = characters.count != 0
        }
    }
    private var searchController: UISearchController?
    private var searchText = "" {
        didSet {
            presenter?.searchCharactersByName(name: searchText)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingSpinner(onView: self.view)
        bindPresenter()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
        removeSpinner()
    }

    // MARK: - Private functions
    
    private func bindPresenter() {
        presenter?.bind(view: self)
    }
    
    private func setupNavigationBar() {
        title = navigationBarTitle
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true
            let navBarAppearance = UINavigationBarAppearance()
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .MarvelRed()
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white] , for: .normal)
    }
    
    private func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController?.searchBar
        searchBar?.tintColor = UIColor.MarvelRed()
        if let searchTextField = searchBar?.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = UIColor.white
            let glassIconView = searchTextField.leftView as! UIImageView
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor.MarvelRed()
            if let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {
                let templateImage =  clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(templateImage, for: [])
                clearButton.tintColor = UIColor.MarvelRed()
            }
        }
        searchBar?.delegate = self
        searchController?.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - CharactersViewControllerProtocol protocol conformance

extension CharactersViewController: CharactersViewControllerProtocol {
    
    func setupView() {
        setupNavigationBar()
        setupSearchBar()
    }
    
    func displayCharacters(_ list: [Character]) {
        characters = list
        charactersCollectionView.reloadData()
    }
    
    func showLoading() {
        self.showSpinner()
    }
    
    func hideLoading() {
        self.hideSpinner()
    }
    
    func showError() {
        // Display error alert
    }
}

// MARK: - UICollectionView Data Source and Delegate

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.0
        return CGSize(width: width, height: 220.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        cell.drawData(character: characters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == characters.count - 1 ) {
            presenter?.loadMarvelCharacters()
         }
    }
}

// MARK: - UISearchBar and UISearchControllerDelegate Delegate

extension CharactersViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
        searchController?.isActive = false
        searchBar.text = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchText != "" {
            searchText = ""
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = searchText
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Do nothing
    }
    
    
}
