//
//  new.swift
//  tut2
//
//  Created by CHAN Cheuk Yin on 3/11/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

class new: NSObject {
    
    //設定要給予cell的屬性
    var food : [Food] = [Food(image: "咖哩飯",name: "阿娟咖哩飯",opening_hr: "時間：\n11:00–21:00", address: "地址：台南市中西區保安路36號", information: "地址：台南市中西區保安路36號\n\n電話：06-2248134；06-2209246\n\n營業時間：11:00 - 21:00\n\n公休：週四\n\n推薦菜色：咖哩飯、雞肉飯、鴨肉羹\n\nFB：https://www.facebook.com/pages/阿娟咖哩飯鴨肉羹/329673023713547", theMenu: "阿娟菜單",storeMap: "阿娟地圖")]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //等等加
    }

}
