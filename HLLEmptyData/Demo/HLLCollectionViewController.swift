//
//  HLLCollectionViewController.swift
//  HLLEmptyDataSet
//
//  Created by  bochb on 2019/6/21.
//  Copyright © 2019 com.heron. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HLLCollectionViewController: UIViewController {

    var count: Int = 0

    var layout = UICollectionViewFlowLayout()
    
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        layout = UICollectionViewFlowLayout()
        layout.itemSize = view.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.hll_setUp()
        collectionView.backgroundColor = UIColor.white
        //初始化时数据源为空, 需要给isEmpty赋值才能显示无数据的提示视图
        collectionView.isEmpty = true
        collectionView.shouldPullRefresh = true
        collectionView.shouldPullLoadMore = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.noDataType = HLLNodataType.noNetworking
        collectionView.loadNewDataBlock = {[weak self] completion in
            sleep(1)
           completion()
            self?.count = 1
            self?.collectionView.reloadData()
        }
        collectionView.loadMoreDataBlock = {[weak self] completion in
            sleep(1)
            completion(self?.count == 2)
            self?.count += 1
            self?.collectionView.reloadData()
        }
        view.addSubview(collectionView)
     
        
  
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
   
        if #available(iOS 11.0, *) {
            collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            // Fallback on earlier versions
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1)
    }
}

extension HLLCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        cell.contentView.backgroundColor = randomColor()
        return cell
    }
}
