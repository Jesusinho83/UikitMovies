//
//  ViewController.swift
//  precticaCoppelMo
//
//  Created by Jesus Grimaldo on 02/12/22.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "The_Movie")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return imageView
    }()
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.placeholder = "E-mail"
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textfield.font = UIFont.systemFont(ofSize: 20)
        textfield.layer.cornerRadius = 10
        return textfield
    }()
    private let passTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.placeholder = "Password"
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textfield.leftViewMode = .always
        textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textfield.font = UIFont.systemFont(ofSize: 20)
        textfield.layer.cornerRadius = 10
        textfield.isSecureTextEntry = true
        return textfield
    }()
    private lazy var loginButton: UIButton = {
        let boton = UIButton(type: .system, primaryAction: UIAction(handler: {_ in
            self.entrar()
        }))
        boton.translatesAutoresizingMaskIntoConstraints = false
        boton.setTitle("Log In", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        boton.layer.cornerRadius = 10
        boton.backgroundColor = .systemBlue
        boton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        return boton
    }()
    private lazy var registrarButton: UIButton = {
        let boton = UIButton(type: .system)
        boton.translatesAutoresizingMaskIntoConstraints = false
        boton.setTitle("Registrar", for: .normal)
        boton.setTitleColor(.white, for: .normal)
        boton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        boton.layer.cornerRadius = 10
        boton.backgroundColor = .systemYellow
        boton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return boton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configConstrains()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (UserDefaults.standard.object(forKey: "sesion") != nil ){
            self.next(identificador: "entrar")
            
        }
    }
    
  
    
    private func configUI() {
        title = "Login The Movie DB"
        view.backgroundColor = .systemGray
    }
    
    private func configConstrains(){
        // Constrains de imagen
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // Constrains de StackView
        view.addSubview(containerStackView)
        containerStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        //Agregar elementos al StackView
        [emailTextField, passTextField, loginButton, registrarButton].forEach {
            containerStackView.addArrangedSubview($0)
        }
    }
    
    private func entrar(){
        guard let emailtxt = emailTextField.text else { return }
        guard let passtxt = passTextField.text else { return }
        FirebaseViewModel.shared.login(email: emailtxt, pass: passtxt) { done in
            if done {
                UserDefaults.standard.set(true, forKey: "sesion")
                self.next(identificador: "entrar")
                
            }
        }
    }
    
    private func registrar(){
        guard let emailtxt = emailTextField.text else { return }
        guard let passtxt = passTextField.text else { return }
        FirebaseViewModel.shared.createUser(email: emailtxt, pass: passtxt) { (done) in
            
            UserDefaults.standard.set(true, forKey: "sesion")
            self.next(identificador: "entrar")
            
        }
    }
    
    func next(identificador: String) {
        performSegue(withIdentifier: identificador, sender: self)
    }
    
    
    
}


