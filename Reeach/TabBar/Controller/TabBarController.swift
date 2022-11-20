//
//  TabBarController.swift
//  Reeach
//
//  Created by Balqis on 08/11/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    let inflationEndPoint = InflationAPI.getInflation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboardVC = DashboardViewController()
        let goalsVC = GoalTrackerViewController()
        let cashflowVC = TrackerEmptyStateViewController()
        let plannerVC = MonthlyPlanningViewController()
        
        setViewControllers([dashboardVC, goalsVC, cashflowVC, plannerVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["Dashboard", "Goals", "Cashflow", "Planning"]
        for x in 0...3 {
            items[x].image = UIImage(named: images[x])
        }
        
        self.tabBar.tintColor = UIColor.ghostWhite
        self.tabBar.isTranslucent = false
        UITabBar.appearance().unselectedItemTintColor = .secondary4
        UITabBar.appearance().barTintColor = .royalHunterBlue
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .royalHunterBlue
            appearance.stackedLayoutAppearance.normal.iconColor = .secondary4
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        setupInflationData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        for tabbarItem in (self.tabBar.items)!{
            let viewTabBar = tabbarItem.value(forKey: "view") as! UIView
            
            if UIDevice.current.hasNotch {
                viewTabBar.frame.origin.y = 5
            } else {
                viewTabBar.frame.origin.y = 18
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = UIScreen.main.bounds.height*0.135
        tabBar.frame.origin.y = view.frame.height - 85
        
        if UIDevice.current.hasNotch {
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        }
        
    }
}

extension TabBarController: NetworkDelegate {
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

extension TabBarController {
    func shouldGetNewRate() -> Bool {
        return UserDefaults.standard.object(forKey: UserDefaultEnum().inflationRate) == nil && Int(UserDefaults.standard.string(forKey: UserDefaultEnum().inflationYear) ?? "2000") != Calendar.current.component(.year, from: Date())
    }
    
    func setupInflationData() {
        print("Get current inflation rate")
        let networkManager = NetworkManager()
        networkManager.networkDelegate = self
        networkManager.createRequest(with: inflationEndPoint)
        return
    }
}
