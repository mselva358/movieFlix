//
//  ViewController.swift
//  MovieFlix
//
//  Created by Selladurai on 11/13/21.
//

import UIKit

class MoviesViewController: UICollectionViewController {
                
    enum Section {
        case movie
    }
    
    var viewModel: MoviesViewModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = MoviesViewModel(controller: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
        if #available(iOS 13.0, *) {
            collectionView?.dataSource = nil
        }
        
        viewModel?.fetchMovies()
        
        // Do any additional setup after loading the view.
    }
    
    func setupSearchBar() {
        self.navigationItem.titleView = {
            let searchBar = UISearchBar(frame: CGRect.init(origin: CGPoint(x: 20, y: 0), size: CGSize.init(width: UIScreen.main.bounds.width - 40, height: 44)))
            searchBar.delegate = self
            searchBar.placeholder = "Search Movies"
            return searchBar
        }()
    }
    
    var dataSource: UICollectionViewDataSource!
    
    @available(iOS 13.0, *)
    func updateLayout() {
        collectionView.setCollectionViewLayout(self.createLayout(), animated: true)
        configureDataSource()
    }
    
    @available(iOS 13.0, *)
    func createLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalWidth(0.5625))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                       subitem: item,
                                                       count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 0
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @available(iOS 13.0, *)
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, Movie>(collectionView: collectionView) {
            [weak self] (collectionView: UICollectionView, indexPath: IndexPath, item: Movie) -> UICollectionViewCell? in
            // Return the cell.
            return self?.viewModel.generateCellForItemAtIndexPath(indexPath)
        }

        // load our data
        let newsItems = viewModel.movieList?.results ?? []
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.movie])
        snapshot.appendItems(newsItems)
        (dataSource as? UICollectionViewDiffableDataSource)?.apply(snapshot, animatingDifferences: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel.movieList?.results?.count ?? 0)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.generateCellForItemAtIndexPath(indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel.movieList?.results?[indexPath.item] {
            viewModel.showMovieDetail(movie)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        For Pagination
//        if indexPath.item == ((self.viewModel.movieList?.results?.count ?? 0) - 1) {
//            self.viewModel.currentPage += 1
//            self.viewModel.fetchMovies()
//        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAtIndexPath(indexPath)
    }
}

extension MoviesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterMoviesByTitle(searchText)
    }

}

