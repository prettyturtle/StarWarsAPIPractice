//
//  DetailViewController.swift
//  StarWarsCharacters
//
//  Created by yc on 2021/11/05.
//

import UIKit
import Alamofire

class DetailViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var heightCell: UITableViewCell!
    @IBOutlet weak var massCell: UITableViewCell!
    @IBOutlet weak var hairColorCell: UITableViewCell!
    @IBOutlet weak var skinColorCell: UITableViewCell!
    @IBOutlet weak var eyeColorCell: UITableViewCell!
    @IBOutlet weak var birthYearCell: UITableViewCell!
    @IBOutlet weak var genderCell: UITableViewCell!
    @IBOutlet weak var homeworldCell: UITableViewCell!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var characterInfo: CharacterInfo?
    
    var homeworld: Homeworld?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.isHidden = true
        self.activityIndicator.startAnimating()

        self.getHomeworld(completionHandler: { result in
            switch result {
            case let .success(result):
                self.homeworld = result
                self.configureDetailView()
            case let .failure(error):
                print("error입니다\(error)")
            }
            
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "상세정보"
    }
    
    private func configureDetailView() {
        guard let characterInfo = self.characterInfo else { return }
        guard let homeworld = self.homeworld else { return }

        self.imageView.image = UIImage(named: "\(characterInfo.name)")
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.imageView.isHidden = false
        self.nameCell.detailTextLabel?.text = "\(characterInfo.name)"
        self.heightCell.detailTextLabel?.text = "\(characterInfo.height)"
        self.massCell.detailTextLabel?.text = "\(characterInfo.mass)"
        self.hairColorCell.detailTextLabel?.text = "\(characterInfo.hair_color)" == "n/a" ? "없음" : "\(characterInfo.hair_color)"
        self.skinColorCell.detailTextLabel?.text = "\(characterInfo.skin_color)"
        self.eyeColorCell.detailTextLabel?.text = "\(characterInfo.eye_color)"
        self.birthYearCell.detailTextLabel?.text = "\(characterInfo.birth_year)"
        self.genderCell.detailTextLabel?.text = "\(characterInfo.gender)" == "n/a" ? "없음" : "\(characterInfo.gender)"
        self.homeworldCell.detailTextLabel?.text = "\(homeworld.name)"
    }

    private func getHomeworld(completionHandler: @escaping (Result<Homeworld, Error>) -> Void) {
        guard let characterInfo = self.characterInfo else { return }
        AF.request(characterInfo.homeworld, method: .get).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let result = try JSONDecoder().decode(Homeworld.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))

            }
        }
    }

}
