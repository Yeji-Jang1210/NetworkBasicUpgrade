//
//  BoxOfficeTableViewCell.swift
//  NetworkBasicUpgrade
//
//  Created by 장예지 on 6/5/24.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    static var identifier: String = String(describing: BoxOfficeTableViewCell.self)
    
    let rankLabel: UILabel = {
        let object = UILabel()
        object.backgroundColor = .white
        object.font = .boldSystemFont(ofSize: 16)
        object.textAlignment = .center
        return object
    }()
    
    let movieNameLabel: UILabel = {
        let object = UILabel()
        object.textColor = .white
        object.font = .boldSystemFont(ofSize: 14)
        return object
    }()
    
    let openDateLabel: UILabel = {
        let object = UILabel()
        object.setContentCompressionResistancePriority(.init(1000), for: .horizontal)
        object.textColor = .white
        object.font = .systemFont(ofSize: 12)
        return object
    }()
    
    let stackView: UIStackView = {
       let object = UIStackView()
        object.axis = .horizontal
        object.alignment = .center
        object.spacing = 12
        return object
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy(){
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(movieNameLabel)
        stackView.addArrangedSubview(openDateLabel)
    }
    
    func configureLayout(){
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(8)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(40)
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.width.equalTo(200).priority(999)
        }
    }
    
    func configureUI(){
        self.backgroundColor = .clear
    }
    
    func setData(_ data: BoxOffice){
        rankLabel.text = data.rank
        movieNameLabel.text = data.movieNm
        openDateLabel.text = data.openDt
    }
}
