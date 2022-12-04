//
//  MoviesViewModel.swift
//  precticaCoppelMo
//
//  Created by Jesus Grimaldo on 02/12/22.
//

import Foundation


class MoviesViewModel {
    
    public static var shared = MoviesViewModel()
    
     var dataMovies: [Result] = []
    
    
    @Published var key = ""
    
    func fetch(completion: @escaping(_ done: Bool) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=f6a11e07af9f1d38e7f16e23c4d88065&language=en-US&page=1") else { return }
        URLSession.shared.dataTask(with: url) {  data, _, _ in
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(MovieModel.self, from: data)
                DispatchQueue.main.async {
                    self.dataMovies = json.results
                    completion(true)
                }
            }catch let error as NSError {
                print("Error en el json", error.localizedDescription)
            }
        }.resume()
       
    }
    
    
    func fetchVideo(id:String) async {
        do{
            
            let urlString = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=f6a11e07af9f1d38e7f16e23c4d88065&language=en-US"
            guard let url = URL(string: urlString ) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONDecoder().decode(videoModel.self, from: data)
            let res = json.results.filter({$0.type.contains("Trailer")})
            self.key = res.first?.key ?? ""
           
            
        }catch let error as NSError {
            print("Error en la api:", error.localizedDescription)
        }
    }
    func fetchTop(completion: @escaping(_ done: Bool) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=f6a11e07af9f1d38e7f16e23c4d88065&language=en-US&page=1") else { return }
        URLSession.shared.dataTask(with: url) {  data, _, _ in
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(MovieModel.self, from: data)
                DispatchQueue.main.async {
                    self.dataMovies = json.results
                    completion(true)
                }
            }catch let error as NSError {
                print("Error en el json", error.localizedDescription)
            }
        }.resume()
       
    }
    
    func fetchUpc(completion: @escaping(_ done: Bool) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=f6a11e07af9f1d38e7f16e23c4d88065&language=en-US&page=1") else { return }
        URLSession.shared.dataTask(with: url) {  data, _, _ in
            guard let data = data else { return }
            do{
                let json = try JSONDecoder().decode(MovieModel.self, from: data)
                DispatchQueue.main.async {
                    self.dataMovies = json.results
                    completion(true)
                }
            }catch let error as NSError {
                print("Error en el json", error.localizedDescription)
            }
        }.resume()
       
    }
   
    
}
