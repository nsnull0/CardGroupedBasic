//
//  MainScreenViewController.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, CardProtocol {
    @IBOutlet weak var cardTableView: UITableView!
    
    static private let CARD_IDENTIFIER = "MAINCARDCELLS"
    static private let CARD_UNTAP_IDENTIFIER = "UNTAPCARDCELLS"
    
    var networkManager:NetworkManager = NetworkManager()
    var cardManager:CardManager = CardManager()
    var alertC:UIAlertController = UIAlertController()
    
    var itemTable:[[Card]] = [[Card]]()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cardTableView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(fetchDataActivity), for: UIControlEvents.valueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "Fetch Card Data")
        
        self.cardManager.delegate = self
        self.itemTable = [[],[]]
        
        self.cardTableView.separatorColor = UIColor.clear
        
        fetchDataActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @objc func fetchDataActivity(){
        networkManager.fetchData { (network, data) in
            if network == NetworkCondition.Success {
                self.cardManager.load(data: data!)
            }else{
                DispatchQueue.main.async {
                    self.alertC = UIAlertController(title: "No Internet Connection",
                                                    message: "Make Sure to Connect Internet",
                                                    preferredStyle: .alert)
                    self.alertC.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                    self.present(self.alertC, animated: true, completion: nil)
                }
                
            }
            DispatchQueue.main.async {
                self.updateViewConstraints()
                self.refreshControl.endRefreshing()
                
            }
            
            
        }
    }
    
    func itemIsLoaded(Correctly: Bool) {
        guard Correctly else {
            alertC = UIAlertController(title: "LOADED DATA PROBLEM [err0001]",
                                       message: "Contact US for err0001",
                                       preferredStyle: .alert)
            alertC.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        itemTable = [self.cardManager.cardCollections, [Card.init("",
                                                                  date: "",
                                                                  amount: "",
                                                                  currency: "",
                                                                  description: "",
                                                                  kind: "",
                                                                  heightContent: CardManager.heightContentDefaultUntap)]]
        
        DispatchQueue.main.async {
            self.cardTableView.reloadData()
        }
        
        
    }
    
}

extension MainScreenViewController:UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemTable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemTable[section].count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let HeaderCell:HeaderCardCell = HeaderCardCell.instanceFromNib()
        
        if (section == 0) {
            
            HeaderCell.HeaderTextLabel.text = "Tappable"
            
        }else{
            
            HeaderCell.HeaderTextLabel.text = "Untappable"
            
        }
        return HeaderCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if indexPath.section == 1 {
            let cell:CardUITableViewCellUnTap = tableView.dequeueReusableCell(withIdentifier: MainScreenViewController.CARD_UNTAP_IDENTIFIER) as! CardUITableViewCellUnTap
            
            
            
            return cell
        }else{
            let cell:CardUITableViewCell = tableView.dequeueReusableCell(withIdentifier: MainScreenViewController.CARD_IDENTIFIER) as! CardUITableViewCell
            
            if indexPath.row == 0 {
                cell.setup(cardData: self.itemTable[indexPath.section][indexPath.row], type: .first)
            } else if indexPath.row == self.itemTable[indexPath.section].count - 1 {
                cell.setup(cardData: self.itemTable[indexPath.section][indexPath.row], type: .last)
            } else {
                cell.setup(cardData: self.itemTable[indexPath.section][indexPath.row], type: .middle)
            }
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            DispatchQueue.main.async {
                self.alertC = UIAlertController(title: "CARD INFO \(self.itemTable[indexPath.section][indexPath.row].id)",
                    message: "Description\n\(self.itemTable[indexPath.section][indexPath.row].description)",
                    preferredStyle: .alert)
                self.alertC.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                self.present(self.alertC, animated: true, completion: nil)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.itemTable[indexPath.section][indexPath.row].heightContent
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
