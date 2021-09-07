//
//  ViewController.swift
//  pokemonAPI
//
//  Created by Rin on 2021/07/26.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    @IBOutlet private weak var serchButton: UIButton!
    @IBOutlet private weak var pokemonNumberTextField: UITextField!
    private let model = PokemonAPIModel()
    private var searchPokemonId: Int?

    @IBAction private func didTapSearchButton(_ sender: UIButton) {
        guard let id = Int(pokemonNumberTextField.text ?? "") else {
            showAlert()
            return
        }
        model.getPokemonName(id: id) {
            DispatchQueue.main.async { [self] in
                imageView.image = UIImage(data: model.pokemonImageData!)
                pokemonNameLabel.text = model.pokemonName
            }
        }
    }

    private func showAlert() {
        let alert = UIAlertController(title: "エラー", message: "数字を入力してください", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .default)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
}
