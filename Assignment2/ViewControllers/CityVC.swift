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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setTitle() {
        if let city = cityName { title = city }
    }
    
    private func configureWebView() {
        webView = WKWebView()
        view = webView
    }
    
    private func configureToolbar() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: webView, action: #selector(webView.goForward))
        toolbarItems = [back,forward, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    private func loadPage() {
        if var urlCity = cityName {
            if urlCity.contains(" ") {
                urlCity = urlCity.replacingOccurrences(of: " ", with: "_")
            }
            webView.load(URLRequest(url: URL(string: "https://en.wikipedia.org/wiki/\(urlCity)")!))
        }
    }
}
