//
//  CityVC.swift
//  Assignment2
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit
import WebKit

class CityVC: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        configureWebView()
        configureToolbar()
        loadPage()
    }
    
    override func viewWillAppear(_ animated: Bool) { navigationController?.showBars() }
    
    private func setTitle() {
        if let city = cityName { title = city }
    }
    
    private func configureWebView() {
        webView = WKWebView()
        view = webView
    }
    
    private func configureToolbar() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let testSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        testSpacer.width = Constants.toolbarSpacerWidth
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(image: UIImage(systemName: Constants.wkBackward), style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(image: UIImage(systemName: Constants.wkForward), style: .plain, target: webView, action: #selector(webView.goForward))
        toolbarItems = [back,testSpacer ,forward, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    private func loadPage() {
        if var urlCity = cityName {
            urlCity = urlCity.makeURLReady()
            print(Constants.baseURL + urlCity)
            webView.load(URLRequest(url: URL(string: Constants.baseURL + urlCity)!))
        }
    }
}
