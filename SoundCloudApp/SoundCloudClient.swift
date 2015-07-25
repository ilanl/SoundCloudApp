
import Foundation
import Alamofire
import SwiftyJSON

private let _sharedInstance = SoundCloudClient()

public class SoundCloudClient: NSObject {
    
    private var clientKey:String = "8c240237b2d8a9551fc4420df24eb447"
    //private var clientKey:String = "d652006c469530a4a7d6184b18e16c81"
    
    //private var clientSecret:String = "db21ced8718485379b53b5713748ee96"
    private let apiBaseUrl:String = "https://api.soundcloud.com/"
    
    public class var sharedInstance: SoundCloudClient {
        return _sharedInstance;
    }
    
    override init() {
        super.init()
        
    }
    
    
    public func searchTracksByQuery(query: String, completionHandler: ([TrackInfo], NSError?) -> Void) {
        
        Alamofire.request(.GET, "\(apiBaseUrl)/tracks.json?client_id=\(self.clientKey)", parameters: ["tags":query,"sharing":"public","limit":20], encoding: .URL).responseJSON { (request, response, json, error) in
            var tracks:[TrackInfo] = []
            
            if let arrayOfJSON = json as? Array<Dictionary<String,AnyObject>>{

                for j in arrayOfJSON{
                    if let t = TrackInfo.parse(j){
                        t.streamUrl += "?client_id=\(self.clientKey)"
                        
                        tracks.append(t)
                    }
                    
                }
            }
            
            completionHandler(tracks, error)
        }
    }
    
    public func retrieveTrackInfo(trackId: String, completionHandler: (TrackInfo?, NSError?) -> Void) {
        Alamofire.request(.GET, "\(apiBaseUrl)/tracks/\(trackId).json?client_id=\(self.clientKey)", parameters: nil, encoding: .URL).responseJSON { (request, response, data, error) in
            var track:TrackInfo?
                if error == nil {
                    if let trackInfo = TrackInfo.parse(data!){
                        trackInfo.streamUrl += "?client_id=\(self.clientKey)"
                        track = trackInfo
                    }
                }
                completionHandler(track, error)
            }
    }
    
}

