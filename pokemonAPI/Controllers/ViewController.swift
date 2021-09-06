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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func changedTextField(_ sender: UITextField) {
    }

    @IBAction private func didTapSearchButton(_ sender: UIButton) {
        model.getPokemonName(id: 1)
        print("1")
    }
}
