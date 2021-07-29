//
//  TeamPageVC.swift
//  A3
//
//  Created by Gökberk Köksoy on 30.07.2021.
//

import UIKit
import WebKit

class TeamPageVC: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    
    var teamName: String?
    var teamURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        configureWebView()
        loadPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.showBars()
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    private func setTitle() {
        if let team = teamName { title = team }
    }
    
    private func configureWebView() {
        webView = WKWebView()
        view = webView
    }
    
    private func loadPage() {
        if let teamURL = teamURL, let url = URL(string: Constants.https + teamURL){
            webView.load(URLRequest(url: url))
        }
    }
}
