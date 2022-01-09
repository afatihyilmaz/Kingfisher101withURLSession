//
//  ViewController.swift
//  Kingfisher101
//
//  Created by Ahmet Fatih YILMAZ on 9.01.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var imageViewDog: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func apiConnection(){
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error != nil || data == nil {
                
                let alert = UIAlertController(title: "Error!!", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
           }
            else {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                        
                        DispatchQueue.main.async {
                            if let imageUrl = json["message"] {
                                self.imageViewDog.kf.setImage(with: URL(string: imageUrl as! String)){result in
                                    switch result {
                                    case .success(let value):
                                        print("indirme Başarılı : \(value.source.url?.absoluteString ?? "")")
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            if let success = json["status"] {
                                print("*************")
                                print("Başarı : \(success)")
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    @IBAction func getRandomDogTapped(_ sender: Any) {
        apiConnection()
    }
    
}

