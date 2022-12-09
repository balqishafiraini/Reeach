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
        let addVC = UIViewController()
        let cashflowVC = CashflowTrackerViewController()
        let plannerVC = MonthlyPlanningViewController()
        
        setViewControllers([dashboardVC, goalsVC, addVC, cashflowVC, plannerVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["Dashboard", "Goals", "","Cashflow", "Planning"]
        for x in 0...4 {
            items[x].image = UIImage(named: images[x])
            if x == 2 {
                items[x].isEnabled = false
            }
        }
        UITabBar.appearance().unselectedItemTintColor = .secondary4
        UITabBar.appearance().tintColor = .ghostWhite
        
        setupInflationData()
        
        setupMiddleButton()
        
        setValue(AppTabBar(frame: tabBar.frame), forKey: "tabBar")
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
        tabBar.frame.origin.y = view.frame.height - 85
        
        if UIDevice.current.hasNotch {
            tabBar.frame.size.height = 120
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        } else {
            tabBar.frame.size.height = 100
            self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 36, right: 0)
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
        let networkManager = NetworkManager()
        networkManager.networkDelegate = self
        networkManager.createRequest(with: inflationEndPoint)
        return
    }
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 78, height: 78))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.backgroundColor = UIColor.tangerineYellow
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        menuButton.setImage(UIImage(named: "Add"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        presentModal()
    }
    private func presentModal() {
        let addButtonViewController = AddButtonViewController()
        addButtonViewController.modalPresentationStyle = .pageSheet
        
        if let viewController = selectedViewController as? DismissViewDelegate {
            addButtonViewController.dismissDelegate = viewController
        }
        
        let nav = UINavigationController(rootViewController: addButtonViewController)
        nav.navigationItem.largeTitleDisplayMode = .never
        nav.navigationBar.setValue(true, forKey: "hidesShadow")
        
        if #available(iOS 15.0, *) {
            nav.sheetPresentationController?.detents = [.medium(), .large()]
            nav.sheetPresentationController?.preferredCornerRadius = 15
        }
        nav.navigationBar.isHidden = true
        present(nav, animated: true, completion: nil)
        
    }
    
}
