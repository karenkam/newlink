//
//  NewLinkViewController.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/20/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import WebKit

class NewLinkViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet var NewLinkWebView: WKWebView!
    @IBOutlet var NewLinkActivityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        //NewLinkActivityIndicator = UIActivityIndicatorView()
        NewLinkActivityIndicator.center = self.view.center
        NewLinkActivityIndicator.hidesWhenStopped = true
        NewLinkActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        
       // NewLinkWebView = WKWebView(frame: CGRect.zero)
        NewLinkWebView.navigationDelegate = self
        NewLinkWebView.uiDelegate = self
        let pdf = Bundle.main.url(forResource: "AboutUs", withExtension: "pdf")
        let request = URLRequest(url: pdf!)
        NewLinkWebView.load(request)
        view.addSubview(NewLinkWebView)
        view.addSubview(NewLinkActivityIndicator)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        DispatchQueue.main.async {
            self.NewLinkActivityIndicator.isHidden = false
            self.NewLinkActivityIndicator.startAnimating()
        }
    }
    func showActivityIndicator(show: Bool) {
        if show {
            print("activity indicator start animating")
            NewLinkActivityIndicator.startAnimating()
        } else {
            NewLinkActivityIndicator.stopAnimating()
            
            print("stop animating")
        }
        
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
        showActivityIndicator(show: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
