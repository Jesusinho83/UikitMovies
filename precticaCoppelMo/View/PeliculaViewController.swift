//
//  PeliculaViewController.swift
//  precticaCoppelMo
//
//  Created by Jesus Grimaldo on 03/12/22.
//

import UIKit

class PeliculaViewController: UIViewController {
    
    var name = ""
    var poster = ""
    var fecha = ""
    var overDescripcion = ""
    var lenguage =  ""
    
    private let mainScrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    private let configStackHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints =  false
        return stack
    }()
    
    private let configStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize:30)
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private let dateLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20)
        title.textAlignment = .left
        title.textColor = .green
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private let idiomaLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 15)
        title.textAlignment = .left
        title.textColor = .green
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private let descripcionLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 25)
        title.textAlignment = .left
        title.textColor = .blue
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    private lazy var favoritoBoton: UIButton = {
        let boton = UIButton(type: .system, primaryAction:  UIAction(handler: {_ in
            self.guardar()
        }))
        var config = UIButton.Configuration.bordered()
        
        config.titleAlignment = .trailing
        config.buttonSize = .mini
        config.image = UIImage(systemName: "star.fill")
        config.imagePlacement = .trailing
        config.baseForegroundColor = .yellow
        
        boton.configuration = config
        boton.translatesAutoresizingMaskIntoConstraints = false
        
        return boton
    }()
    private let favLabel: UILabel = {
        let title = UILabel()
        title.text = "Favorito"
        title.font = .systemFont(ofSize: 25)
        title.textAlignment = .left
        title.textColor = .green
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configInterface()
        configConstrains()
        configCard()
        
      
        //titleLabel.text = name
        
    }
    
    func configInterface(){
        title = "\(name)"
        view.backgroundColor = .systemGray2
    }
    
    private func configConstrains(){
        
        view.addSubview(mainScrollView)
        let safeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets
        
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mainScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mainScrollView.addSubview(configStackView)
        configStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: safeAreaInset?.bottom ?? 0.0).isActive = true
        configStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor).isActive = true
        configStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor ).isActive = true
        configStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant:  -(safeAreaInset?.top ?? 0.0)).isActive = true
        
       
       
        
        configStackView.addArrangedSubview(posterImageView)
        configStackView.addArrangedSubview(titleLabel)
        configStackView.addArrangedSubview(dateLabel)
        configStackView.addArrangedSubview(idiomaLabel)
        configStackView.addArrangedSubview(configStackHorizontal)
        configStackHorizontal.addArrangedSubview(favLabel)
        configStackHorizontal.addArrangedSubview(favoritoBoton)
        configStackView.addArrangedSubview(descripcionLabel)
        
        
        
    }
    
    func configCard() {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w200/\( poster )") else { fatalError("sin imagen") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.posterImageView.image = image
                self.titleLabel.text = self.name
                self.dateLabel.text = self.fecha
                self.idiomaLabel.text = self.lenguage
                self.descripcionLabel.text = self.overDescripcion
                
            }
            
        }
        
    }
    func guardar(){
        print("guardar")
        let alerta = UIAlertController(title: "Agregar", message: "¿Agregar a Favoritos?", preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
            print("se a agreado")
            FirebaseViewModel.shared.save(titulo: self.name, portada: self.poster, descripcion: self.overDescripcion, fecha: self.fecha) { done in
                
            }
            
        }
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
