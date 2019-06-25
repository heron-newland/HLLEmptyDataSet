//
//  HLLScrollViewController.swift
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/21.
//  Copyright © 2019 com.heron. All rights reserved.
//

import UIKit

class HLLScrollViewController: UIViewController {

    var count: Int = 0
    var subV:[UIView] = Array<UIView>()
    
    var scroll: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.hll_setUp()
     scroll.noDataType = HLLNodataType.noNetworking
        return scroll
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(scroll)
        scroll.delegate = self
        //初始化时数据源为空, 需要给isEmpty赋值才能显示无数据的提示视图
        scroll.isEmpty = true
        scroll.shouldPullRefresh = true
        scroll.shouldPullLoadMore = true
        generalContent()
        scroll.loadNewDataBlock = {[weak self] completion in
            sleep(2)
            self?.count = 1
            completion()
            self?.scroll.isEmpty = false
            self?.generalContent()
        }
        

        //加载更多
        scroll.loadMoreDataBlock = {[weak self] completion in
            sleep(2)
            completion(self?.count == 2)
            self?.scroll.isEmpty = false
            self?.count += 1
            self?.scroll.contentSize = CGSize(width: self?.view.bounds.width ?? 0, height: 900.00 * CGFloat(self?.count ?? 0))
            self?.generalContent()
        }
        // Do any additional setup after loading the view.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scroll.contentSize = CGSize(width: view.bounds.width, height: 900)
    }

    func config() {
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            scroll.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            // Fallback on earlier versions
        }
    }
    
    func generalContent() {
        if scroll.subviews.count > 0 {
        for i in 0 ..< subV.count{
            subV[i].removeFromSuperview()
        }
        }
        for i in 0 ..< count {
            let v = UIView(frame: CGRect(x: 0, y: 900.0 * CGFloat(i), width: view.bounds.width, height: 900))
            v.backgroundColor = randomColor()
            scroll.addSubview(v)
            subV.append(v)
        }
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1)
    }
}

extension HLLScrollViewController: UIScrollViewDelegate{
    
}
