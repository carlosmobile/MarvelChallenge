//
//  CharacterWikiViewController.swift
//  MarvelChallenge
//
//  Created by Carlos Butrón on 11/3/22.
//

import UIKit
import WebKit

class CharacterWikiViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!

    var characterWikiURL: String = ""
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        configureActivityIndicator()
        configureWebView()
    }

    func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.isHidden = true

        view.addSubview(activityIndicator)
    }

    func configureWebView() {
        let wikiUrl = URL.init(string: characterWikiURL)
        guard let url = wikiUrl else {
            return
        }
        let request = URLRequest.init(url: url)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
