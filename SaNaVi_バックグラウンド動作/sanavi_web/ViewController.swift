import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,UIWebViewDelegate{
    
    var targetURL = "https://toba-sanavi.azurewebsites.net/iostest.html"
    let webView : UIWebView = UIWebView()
    var myLocationManager:CLLocationManager!
    var lat_text = ""
    var lon_text = ""
    var direction_text = ""
    var speed_text = ""
    var time_text = ""
    var accele_x_text = ""
    var accele_y_text = ""
    var accele_z_text = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        webView.delegate = self
        webView.frame = self.view.bounds
        self.view.addSubview(webView)
        
        let requestURL = URL(string: targetURL)
        let req = URLRequest(url: requestURL!)
        self.webView.loadRequest(req)
        
        // フィールドの初期化
        lm = CLLocationManager()
        longitude = CLLocationDegrees()
        latitude = CLLocationDegrees()
        
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
        // 位置情報の精度を指定．任意，
        lm.desiredAccuracy = kCLLocationAccuracyBest
        // 位置情報取得間隔を指定．指定した値（メートル）移動したら位置情報を更新する．任意．
        lm.distanceFilter = 1000
        
        // GPSの使用を開始する
        lm.startUpdatingLocation()
        
        // バックグラウンドをONに
        lm.allowsBackgroundLocationUpdates = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // your code here
            self.webView.stringByEvaluatingJavaScript(from : "swiftJS();")
            print("実行！！！")
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if(request.url!.scheme == "jsnoty"){
            //ここで何かする
            print("OK!")
            print(request.url!.absoluteString)
            let urlstring = request.url!.absoluteString
            Text_split(urlstring)
            return false;
        }
        print("です")
        return true
    }
    
    //文字列のスプリット
    func Text_split(_ str: String){
        let words = str.components(separatedBy: ",")
        if(words[0] != "0"){
            //var string = words[2];
            //var replaced = string.replacingOccurrences(of: "null", with: "0")
            
            lat_text += words[0]+","
            lon_text += words[1]+","
            //direction_text += replaced+","
            //speed_text += words[3]+","
            //time_text += words[4]+","
            //accele_x_text += words[5]+","
            //accele_y_text += words[6]+","
            //accele_z_text += words[7]+","
            
            print(lon_text)
            print("")
        }
    }

    
    // 現在地の位置情報の取得にはCLLocationManagerを使用
    var lm: CLLocationManager!
    // 取得した緯度を保持するインスタンス
    var latitude: CLLocationDegrees!
    // 取得した経度を保持するインスタンス
    var longitude: CLLocationDegrees!
    
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(manager: CLLocationManager!, didUpdateToLocations locations: [CLLocation]){
        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
        //latitude = manager.location.coordinate.latitude
        
        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
        //longitude = manager.location.coordinate.longitude
        
        // 取得した緯度・経度をLogに表示
        //NSLog("latiitude: \(latitude) , longitude: \(longitude)")
        
        // GPSの使用を停止する．停止しない限りGPSは実行され，指定間隔で更新され続ける．
        // lm.stopUpdatingLocation()
    }
    
    /* 位置情報取得失敗時に実行される関数 */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // この例ではLogにErrorと表示するだけ．
        NSLog("Error")
    }
    
    
}

