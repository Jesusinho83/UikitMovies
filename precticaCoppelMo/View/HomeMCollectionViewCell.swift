//
//  HomeMCollectionViewCell.swift
//  precticaCoppelMo
//
//  Created by Jesus Grimaldo on 02/12/22.
//

import UIKit

class HomeMCollectionViewCell: UICollectionViewCell {
    private let configStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let configStackViewHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 15)
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private let dateLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 10)
        title.textAlignment = .left
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private let calificacionLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 30)
        title.textAlignment = .left
        title.textColor = .blue
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private let descripcionLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 15)
        title.textAlignment = .left
        title.textColor = .purple
        title.numberOfLines = 4
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
  
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configConstrains()
        
    }
    
    private func configConstrains(){
        
        // Constrains de StackView
        addSubview(configStackView)
        configStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        configStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        configStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        
        configStackView.addArrangedSubview(movieImageView)
        configStackView.addArrangedSubview(titleLabel)
        configStackView.addArrangedSubview(configStackViewHorizontal)
        configStackViewHorizontal.addArrangedSubview(dateLabel)
        configStackViewHorizontal.addArrangedSubview(calificacionLabel)
        configStackView.addArrangedSubview(descripcionLabel)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configCard(model: Result) {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w200/\(model.poster_path ?? "" )") else { fatalError("sin imagen") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.movieImageView.image = image
                self.titleLabel.text = model.original_title
                self.dateLabel.text = model.release_date
                // self.calificacionLabel.text = model.vote_average
                self.descripcionLabel.text = model.overview
                
            }
            
        }
        
    }
    
}
