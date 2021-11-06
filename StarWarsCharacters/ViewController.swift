//
//  ViewController.swift
//  StarWarsCharacters
//
//  Created by yc on 2021/11/04.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var characterList = [CharacterInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        
        self.configureCollectionView()
        self.collectionView.isHidden = true

//        print("-----------------1-----------------")
        
        for count in 1...9 {
            self.getCharacters(page: count, completionHandler: { result in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.collectionView.isHidden = false

//                print("-----------------2-----------------")
                switch result {
                case let .success(result):
//                    print("-----------------3-----------------")
    //                debugPrint("success \(result)")
                    self.characterList.append(contentsOf: result.results)
                    
                    self.collectionView.reloadData()
//                    print("-----------------4-----------------")
                case let .failure(error):
//                    print("-----------------5-----------------")
    //                debugPrint("failure \(error)")
                    print("error입니다\(error)")
//                    print("-----------------6-----------------")
                }
            })
        }
        
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func getCharacters(page: Int, completionHandler: @escaping (Result<CharacterInfoList, Error>) -> Void) {
//        print("-----------------7-----------------")
        let url = "https://swapi.dev/api/people/?page=\(page)"
        AF.request(url, method: .get).responseData { response in
//            print("-----------------8-----------------")
            switch response.result {
            case let .success(data):
//                print("-----------------9-----------------")
                do {
//                    print("-----------------10-----------------")
                    let result = try JSONDecoder().decode(CharacterInfoList.self, from: data)
//                    print("-----------------11-----------------")
                    completionHandler(.success(result))
//                    print("-----------------12-----------------")
                } catch {
//                    print("-----------------13-----------------")
                    completionHandler(.failure(error))
//                    print("-----------------14-----------------")
                }
            case let .failure(error):
//                print("-----------------15-----------------")
                completionHandler(.failure(error))
//                print("-----------------16-----------------")
            }
        }

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characterList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.nameLabel.text = characterList[indexPath.row].name
        cell.imageView.image = UIImage(named: "\(characterList[indexPath.row].name)")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("눌렸음")
        
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailViewController.characterInfo = characterList[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 230)
    }
}

