//
//  CharacterDetailViewController.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

final class CharacterDetailViewController: BaseViewController {
    
    @IBOutlet weak var comicsTableView: UITableView! {
        didSet {
            comicsTableView.delegate = self
            comicsTableView.dataSource = self
            comicsTableView.register(UINib(nibName: "ComicTableViewCell", bundle: nil), forCellReuseIdentifier: comicCellIdentifier)
            comicsTableView.register(UINib(nibName: "CharacterInfoTableViewCell", bundle: nil), forCellReuseIdentifier: characterInfoCellIdentifier)
            comicsTableView.rowHeight = UITableView.automaticDimension
            comicsTableView.estimatedRowHeight = 160
        }
    }
    @IBOutlet weak var emptyTableLabel: UILabel!
    
    // MARK: Public variables
    
    var presenter: CharacterDetailPresenterProtocol?
    
    // MARK: - Private constants

    private let comicCellIdentifier = "comicCell"
    private let characterInfoCellIdentifier = "characterInfoCell"
    private let tableHeaderText = "COMICS"
    private let tableSections = 2
    private let characterRows = 1
    private let tableHeaderHeight: CGFloat = 40
    
    // MARK: - Private variables
    
    private var character: Character?
    private var comics = [Comic]() {
        didSet {
            emptyTableLabel.isHidden = comics.count != 0
        }
    }

    // MARK: - Initializers
    
    init(character: Character) {
        self.character = character
        
        super.init(nibName: "CharacterDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
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
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - CharacterDetailViewControllerProtocol protocol conformance

extension CharacterDetailViewController: CharacterDetailViewControllerProtocol {
    
    func setupView() {
        if let characterId = character?.id {
            presenter?.loadCharacterComics(characterId: characterId)
        }
        setupNavigationBar()
    }
    
    func displayComics(_ list: [Comic]) {
        comics = list
        comicsTableView.reloadData()
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

// MARK: - UITableView Data Source and Delegate

extension CharacterDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return characterRows
        }
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return tableHeaderHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableHeaderHeight))
            view.backgroundColor = UIColor.MarvelRed()
            let textLayer = UILabel(frame: CGRect(x: 0, y: 5, width: view.bounds.width, height: view.bounds.height - 10))
            textLayer.textColor = UIColor.white
            textLayer.textAlignment = .center
            let textString = NSMutableAttributedString(string: tableHeaderText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            textLayer.attributedText = textString
            view.addSubview(textLayer)
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: characterInfoCellIdentifier, for: indexPath) as! CharacterInfoTableViewCell
            cell.drawData(character: character!)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: comicCellIdentifier, for: indexPath) as! ComicTableViewCell
        cell.drawData(comic: comics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == comics.count - 1 ) {
            if let characterId = character?.id {
                presenter?.loadCharacterComics(characterId: characterId)
            }
        }
    }
}
