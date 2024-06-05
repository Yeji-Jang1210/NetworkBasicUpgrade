//
//  MarketViewController.swift
//  NetworkBasicUpgrade
//
//  Created by 장예지 on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

struct Market: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {
    
    let tableView = UITableView()

    var list: [Market] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function, "1111111")
        
        callRequest()
        
        print(#function, "2222222")
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func callRequest(){
        print(#function, "3333333")
        
        //깃허브에 올리면 안됨!!! -> 따라서 swift파일 하나 만들어두고 올리지 말기(.gitignore에 추가)
        //let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(APIURL.upbitURL).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let markets):
                self.list = markets
                print("SUCCESS")
            case .failure(let error):
                print(error)
            }
        }
        
        print(#function, "4444444")
    }
    
    func configureHierarchy(){
        view.addSubview(tableView)
    }
    
    func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI(){
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemGray6
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function,list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        cell.nameLabel.text = list[indexPath.row].market
        return cell
    }
}
