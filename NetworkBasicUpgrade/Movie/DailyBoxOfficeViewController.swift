//
//  DailyBoxOfficeViewController.swift
//  NetworkBasicUpgrade
//
//  Created by 장예지 on 6/5/24.
//

import UIKit
import SnapKit
import Alamofire

class DailyBoxOfficeViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let object = UIImageView()
        object.contentMode = .scaleAspectFill
        object.image = UIImage(named: "background")
        return object
    }()
    
    let overlayView: UIView = {
        let object = UIView()
        object.backgroundColor = .black.withAlphaComponent(0.7)
        return object
    }()
    
    let searchTextField: UITextField = {
        let object = UITextField()
        object.attributedPlaceholder = NSAttributedString(string: "날짜를 입력해주세요 (yyyyMMdd)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        object.font = .systemFont(ofSize: 14)
        object.textColor = .white
        object.borderStyle = .none
        return object
    }()
    
    let searchButton: UIButton = {
        let object = UIButton(type: .system)
        object.setTitle("검색", for: .normal)
        object.setTitleColor(.black, for: .normal)
        object.titleLabel?.font = .systemFont(ofSize: 16)
        object.backgroundColor = .white
        return object
    }()
    
    let seperatorView: UIView = {
        let object = UIView()
        object.backgroundColor = .white
        return object
    }()
    
    let tableView: UITableView = UITableView()
    
    var pastDate: String {
        get{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyyMMdd"
            return dateFormat.string(from: Date.now - 86400)
        }
    }
    
    var boxOfficeList: [BoxOffice] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureTableView()
        configureUI()
        configureAction()
        
        callRequest(date: pastDate)
    }

    func configureHierarchy(){
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(seperatorView)
        view.addSubview(tableView)
    }

    func configureLayout(){
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(searchButton.snp.leading).offset(-20)
            make.bottom.equalTo(seperatorView.snp.top).inset(4)
            make.top.equalTo(searchButton.snp.top)
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        
        seperatorView.snp.makeConstraints { make in
            make.bottom.equalTo(searchButton.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(searchTextField.snp.trailing)
            make.height.equalTo(2)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
    }

    func configureUI(){
        tableView.backgroundColor = .clear
        tableView.rowHeight = 44
    }
    
    func configureAction(){
        searchButton.addTarget(self, action: #selector(searchBoxOffice), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(searchBoxOffice), for: .editingDidEndOnExit)
    }
    
    func callRequest(date: String?){
        if let date = validateDateFormat(text: date) {
            let url = "\(APIURL.movieURL)\(APIKey.movieKey)=\(date)"
            AF.request(url).responseDecodable(of: MovieData.self) { response in
                switch response.result {
                case .success(let result):
                    self.boxOfficeList = result.boxOfficeResult.dailyBoxOfficeList
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc func searchBoxOffice(_ sender: Any?) {
        callRequest(date: searchTextField.text)
    }
    
    func validateDateFormat(text: String?) -> String?{
        guard let text else {
            showErrorAlert()
            return nil
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyyMMdd"
        guard let date = dateFormat.date(from: text) else {
            showErrorAlert()
            searchTextField.text = ""
            return nil
        }
    
        return dateFormat.string(from: date)
    }

    func showErrorAlert(){
        let alert = UIAlertController(title: "오류", message: "잘못된 날짜 형식입니다.(yyyyMMdd)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension DailyBoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as! BoxOfficeTableViewCell
        cell.setData(boxOfficeList[indexPath.row])
        return cell
    }
}
