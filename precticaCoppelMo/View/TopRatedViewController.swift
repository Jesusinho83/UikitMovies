//
//  TopRatedViewController.swift
//  precticaCoppelMo
//
//  Created by Jesus Grimaldo on 03/12/22.
//

import UIKit

class TopRatedViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
  
    
    
    private let movieColectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 180, height: 350)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemGray2
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configConstrains()
        
        movieColectionView.dataSource = self
        movieColectionView.delegate = self
        
        movieColectionView.register(HomeMCollectionViewCell.self, forCellWithReuseIdentifier: "HomeMCollectionViewCell")
        
        MoviesViewModel.shared.fetchTop { done in
            if done {
                self.movieColectionView.reloadData()
            }
        }
    }
    
    private func configUI() {
        title = "tv Shows"
        view.backgroundColor = .systemGray2
    }
    private func configConstrains(){
        view.addSubview(movieColectionView)
        movieColectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieColectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        movieColectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5 ).isActive = true
        movieColectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MoviesViewModel.shared.dataMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMCollectionViewCell", for: indexPath) as! HomeMCollectionViewCell
        let user = MoviesViewModel.shared.dataMovies[indexPath.row]
        cell.backgroundColor = .yellow
        
        cell.configCard(model: user)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PeliculaViewController()
        let user = MoviesViewModel.shared.dataMovies[indexPath.row]
        vc.name = user.original_title
        vc.poster = user.poster_path ?? ""
        vc.fecha = user.release_date
        vc.overDescripcion = user.overview
        vc.lenguage = user.originalLanguage ?? ""
        self.navigationController?.pushViewController(vc , animated: true)
        
    }

}
