//
//  MarketTableViewCell.swift
//  NetworkBasicUpgrade
//
//  Created by 장예지 on 6/5/24.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: MarketTableViewCell.self)
    
    let nameLabel = UILabel()

    //셀의 정적인 요소를 초기화 - 한번만 호출
    //NIB == XIB >>> XIB가 없다면 이 코드는 실행 X
    //코드베이스에서 사용하지 X
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //코드베이스에서 사용하는 초기화 구문
    //viewDidLoad와 비슷
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //VC view대신 contentView에!!
        //꼭 contentView에!! addSubView에 하면 동작이슈가 없음
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        nameLabel.textColor = .darkGray
        nameLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
