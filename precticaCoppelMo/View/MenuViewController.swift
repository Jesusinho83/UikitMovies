//
//  MenuViewController.swift
//  precticaCoppelMo
//
//  Created by Jesus Grimaldo on 02/12/22.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    private lazy var salirBoton: UIButton = {
        let boton = UIButton(type: .system, primaryAction:  UIAction(handler: {_ in
            self.salir()
        }))
        var config = UIButton.Configuration.bordered()
        config.title = "Cerrar Sesion"
        config.titleAlignment = .center
        config.buttonSize = .large
        
        
        boton.configuration = config
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
    }()

    private lazy var favBoton: UIButton = {
        let boton = UIButton(type: .system, primaryAction:  UIAction(handler: {_ in
            self.fav()
        }))
        var config = UIButton.Configuration.bordered()
        config.title = "Favoritos"
        
        config.image = UIImage(systemName:  "star.fill")
        config.titleAlignment = .center
        config.buttonSize = .large
        config.baseForegroundColor = .yellow
        
        boton.configuration = config
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
    }()
    private lazy var topRatedBoton: UIButton = {
        let boton = UIButton(type: .system, primaryAction:  UIAction(handler: {_ in
            self.top()
        }))
        var config = UIButton.Configuration.bordered()
        config.title = "Top Rated"
        
        config.image = UIImage(systemName:  "play.tv.fill")
        config.titleAlignment = .center
        config.buttonSize = .large
        
        
        boton.configuration = config
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
    }()
    private lazy var upcomingBoton: UIButton = {
        let boton = UIButton(type: .system, primaryAction:  UIAction(handler: {_ in
            self.upcoming()
        }))
        var config = UIButton.Configuration.bordered()
        config.title = "Upcoming"
        
        config.image = UIImage(systemName:  "play.tv.fill")
        config.titleAlignment = .center
        config.buttonSize = .large
        
        
        boton.configuration = config
        boton.translatesAutoresizingMaskIntoConstraints = false
        return boton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray2
        configConstrains()
    }
    
    private func configConstrains(){
        view.addSubview(containerStackView)
        containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        containerStackView.addArrangedSubview(topRatedBoton)
        containerStackView.addArrangedSubview(upcomingBoton)
        containerStackView.addArrangedSubview(favBoton)
        containerStackView.addArrangedSubview(salirBoton)

    }
    private func salir() {
        try! Auth.auth().signOut()
        UserDefaults.standard.removeObject(forKey: "sesion")
        
        dismiss(animated: true, completion: nil)
    }
    
    private func fav(){
        navigationController?.pushViewController(FavoritosViewController(), animated: true)
    }
    private func top(){
        navigationController?.pushViewController(TopRatedViewController(), animated: true)
    }
    
    private func upcoming(){
        navigationController?.pushViewController(UpcomingViewController(), animated: true)
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
