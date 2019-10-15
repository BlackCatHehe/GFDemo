//
//  JYWLocationManager.swift
//  TheWorld
//
//  Created by payTokens on 2019/2/23.
//  Copyright © 2019年 payTokens. All rights reserved.
//

import CoreLocation
import RxSwift
import RxCocoa


protocol JYWLocationDelegate: class {
    
    func didFailOpenService(_ manager: JYWLocationManager)
    func manager(_ manager: JYWLocationManager, updateLocationSuccessWith location: CLPlacemark, coordinate: CLLocationCoordinate2D)
    func manager(_ manager: JYWLocationManager, didFailWithError error: Error)
    
}

public class JYWLocationManager: NSObject {

    //单例
    static let shareInstance = JYWLocationManager()
    
    let locationManager : CLLocationManager
    
    weak var delegate: JYWLocationDelegate?
    
    @objc dynamic var currentLocation : String?
    
    override init() {
        locationManager = CLLocationManager()
        
        //设置定为精准度
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        //250m更新一次定位信息
        locationManager.distanceFilter = 2500
        
        //使用应用程序期间允许访问位置数据
        locationManager.requestWhenInUseAuthorization()
        
        // 设置iOS设备是否可暂停定位来节省电池的电量。如果该属性设为“YES”，则当iOS设备不再需要定位数据时，iOS设备可以自动暂停定位。
        locationManager.pausesLocationUpdatesAutomatically = true
        
        super.init()
        locationManager.delegate = self
        
    }
    
    func startUpdateLocation() {
        //开始定位
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }else{
            if delegate != nil {
                delegate?.didFailOpenService(.shareInstance)
            }
        }
    }
    
    deinit {
        print("JYWLocationManager.deinit")
    }
}


extension JYWLocationManager: CLLocationManagerDelegate{
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("第几次")
        if let newLocation = locations.last{
            CLGeocoder().reverseGeocodeLocation(newLocation) {[weak self] (pms, err) in
                
                self!.locationManager.stopUpdatingLocation()//定位一次后停止定位，节省电
                
                if let newCoordinate = pms?.last?.location?.coordinate{
                    let _ = newCoordinate//获取定位的经纬度
                    
                    //取得最后一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
                    let placemark :CLPlacemark = (pms?.last)!
                    
                    if self?.delegate != nil {
                        self?.delegate?.manager(.shareInstance, updateLocationSuccessWith: placemark, coordinate: newCoordinate)
                    }
//                    let location = placemark.location//位置
//                    let region = placemark.region//区域
//                    let addressDic = placemark.addressDictionary;//详细地址信息
                    
//                    let name=placemark.name;//地名
//                    let thoroughfare=placemark.thoroughfare;//街道
//                    let subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
//                    let locality=placemark.locality; // 城市
//                    let subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
//                    let administrativeArea=placemark.administrativeArea; // 州
//                    let subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
//                    let postalCode=placemark.postalCode; //邮编
//                    let ISOcountryCode=placemark.ISOcountryCode; //国家编码
//                    let country=placemark.country; //国家
//                    let inlandWater=placemark.inlandWater; //水源、湖泊
//                    let ocean=placemark.ocean; // 海洋
//                    let areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
                    if let country = placemark.country,let locality = placemark.locality, let name = placemark.name{
                        self!.currentLocation = country + locality + name
                        print(self!.currentLocation!)
                        
                    }
                }
                
            }
        }
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (error as NSError).domain == kCLErrorDomain && (error as NSError).code == CLError.Code.denied.rawValue{
            if delegate != nil {
                delegate?.manager(.shareInstance, didFailWithError: error)
            }
        }
    }
}

