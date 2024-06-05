//
//  ViewController.swift
//  NetworkBasicUpgrade
//
//  Created by 장예지 on 6/5/24.
//

import UIKit
import SnapKit
import Alamofire
import Toast

struct Lotto: Decodable {
    let drwNoDate: String
    let totSellamnt: Int
//    let firstWinamnt: Int
//    let firstPrzwnerCo: Int
//    let drwtNo1: Int
//    let drwtNo2: Int
//    let drwtNo3: Int
//    let drwtNo4: Int
//    let drwtNo5: Int
//    let drwtNo6: Int
//    let bnusNo: Int
//    let drwNo: Int
}

class ViewController: UIViewController {
    
    let numberTextField = UITextField()
    let checkButton = UIButton()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy(){
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout(){
        numberTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(checkButton.snp.bottom).offset(20)
        }
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        resultLabel.numberOfLines = 0
        
        numberTextField.backgroundColor = .systemGray6
        numberTextField.keyboardType = .numberPad
        
        checkButton.backgroundColor = .systemMint
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.setTitle("로또 당첨 번호 확인", for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        resultLabel.backgroundColor = .orange
    }


    //1. URL
    //2. responseString확인
    //3. nil
    @objc func checkButtonTapped(){
        let url = "\(APIURL.lottoURL)\(numberTextField.text!)"

        //만약 서버와의 통신은 성공했지만, 잘못된 값이 들어와 데이터가 nil일경우의 처리도 중요
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                print(lotto)
                self.resultLabel.text = "\(lotto.drwNoDate)\n1등 당첨 금액: \(lotto.totSellamnt.formatted())원"
            case .failure(let error):
                print(error)
                self.resultLabel.text = "올바른 값을 입력해주세요."
            }
        }
    }
}

