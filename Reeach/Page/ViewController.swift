//
//  ViewController.swift
//  Reeach
//
//  Created by Balqis on 04/10/22.
//
import UIKit

class ViewController: UIViewController {

    let inflationEndPoint = InflationAPI.getInflation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupInflationData()
    }


}

extension ViewController: NetworkDelegate {
    func onResponse(from endPoint: EndPointType?, result: Result<Data, NetworkError>) {
        if let _ = endPoint as? InflationAPI {
            switch result {
            case .success(let data):
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [Any] {
                        let decoder = JSONDecoder()
                        let inflationNetwork: [InflationDetail] = try decoder.decode([InflationDetail].self, from: JSONSerialization.data(withJSONObject: json[1], options: .fragmentsAllowed))
                        
                        saveInflationToUserDefaults(inflationNetwork[0])
                    }
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func saveInflationToUserDefaults(_ inflationData: InflationDetail) {
        let defaults = UserDefaults.standard
        defaults.set(inflationData.date, forKey: UserDefaultEnum().inflationYear)
        defaults.set(inflationData.value, forKey: UserDefaultEnum().inflationRate)
    }
}

extension ViewController {
    func shouldGetNewRate() -> Bool {
        return UserDefaults.standard.object(forKey: UserDefaultEnum().inflationRate) == nil && Int(UserDefaults.standard.string(forKey: UserDefaultEnum().inflationYear) ?? "2000") != Calendar.current.component(.year, from: Date())
    }
    
    func setupInflationData() {
//        if shouldGetNewRate() {
        print("Get current inflation rate")
        let networkManager = NetworkManager()
        networkManager.networkDelegate = self
        networkManager.createRequest(with: inflationEndPoint)
        return
//        }
    }
}
