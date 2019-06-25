//
//  ViewController.swift
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/19.
//  Copyright © 2019 com.heron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let table: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.hll_setUp()
//        table.shouldPullRefresh = false
//        table.shouldPullLoadMore = false
        table.shouldPullRefresh = true
        table.shouldPullLoadMore = true
        table.noDataType = HLLNodataType.noNetworking
        table.tableFooterView = UIView()
        
        return table
    }()
    
    var data:[String] = [String]()
    let cellId = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //如果不是网络请求, 而是直接加载数据时判断是否为空,来决定是否显示emptyDataSet
        table.isEmpty = data.count == 0
        
        //配置table
        table.separatorStyle = .none
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(table)
        
        //下拉刷新
        table.loadNewDataBlock = {[weak self] completion in
            sleep(2)
            completion()
            self?.data = ["one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one","one"]
            self?.table.isEmpty = self?.data.count == 0
            self?.table .reloadData()
        }
        
        //加载更多
        table.loadMoreDataBlock = {[weak self] completion in
            sleep(2)
            completion(true)
            self?.data = []
            self?.table .reloadData()
            self?.table.isEmpty = self?.data.count == 0
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            table.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            // Fallback on earlier versions
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row % 3 == 0 {
            navigationController?.pushViewController(HLLScrollViewController(), animated: true)
        }else if indexPath.row % 3 == 1 {
            
            navigationController?.pushViewController(HLLCollectionViewController(), animated: true)
            
        }else{
            navigationController?.pushViewController(HLLSmallViewController(), animated: true);
        }
        print(indexPath)
    }
    
}
