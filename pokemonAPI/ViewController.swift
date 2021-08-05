//
//  ViewController.swift
//  pokemonAPI
//
//  Created by Rin on 2021/07/26.
//

import UIKit

class ViewControllerModel {
    
    func fetchData(number: Int, setLabel: UILabel, setImage: UIImageView) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-form/\(number)/") else { return }
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            do {
                guard let data = data else { return }
                
                guard let name = try? JSONDecoder().decode(Names.self, from: data).name else { return }
                
                guard let image = try? JSONDecoder().decode(Names.self, from: data).sprites else { return }
                let url = URL(string: image.front_default)
                let imageData = try? Data(contentsOf: url!)
                
                self.settingImage(imageData: imageData!, setImage: setImage)
                self.settingNmae(nameData: name, setLabel: setLabel)
                            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
    
    func settingImage(imageData: Data, setImage: UIImageView) {
        DispatchQueue.main.async {
            setImage.image = UIImage(data: imageData)
        }
    }
    
    func settingNmae(nameData:String,setLabel: UILabel) {
        DispatchQueue.main.async {
            setLabel.text = nameData
        }
    }
    
}

struct Names: Codable {
    let name: String
    let sprites: Images
}

struct Images: Codable {
    let front_default: String
}




class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    var viewModel = ViewControllerModel()
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData(number: 1, setLabel: label, setImage: image)
    }

    @IBAction func button(_ sender: UIButton) {
        viewModel.fetchData(number: Int(textField.text!)!, setLabel: label, setImage: image)
        
    }
}


