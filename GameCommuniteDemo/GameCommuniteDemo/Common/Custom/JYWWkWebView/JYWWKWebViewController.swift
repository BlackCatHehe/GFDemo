//
//  JYWWKWebViewController.swift
//  TemplateProject
//
//  Created by payTokens on 2019/4/24.
//  Copyright © 2019 Qianyuan. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

fileprivate struct Metric{
    static let screenW: CGFloat = UIScreen.main.bounds.width
    static let screenH: CGFloat = UIScreen.main.bounds.height
    static let kStatusBarheight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    
    
    static let hideDuration: TimeInterval = 0.5
    static var myContext = 0
    static let statusH: CGFloat = UIApplication.shared.statusBarFrame.height
}

@objc class JYWWKWebViewController: UIViewController {

    @objc var openUrl: URL?{
        willSet{
            guard newValue != nil else {
                return
            }
            let request = URLRequest(url: newValue!)
            wkWebV.load(request)
        }
    }
    
    
    lazy private var wkWebV: WKWebView = {[unowned self] in

        //网页适配屏幕宽度,禁止缩放
        let jsString = String(format: "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=%f, user-scalable=no');document.getElementsByTagName('head')[0].appendChild(meta);", kScreenW)
        let userScript = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        // 禁止选择CSS
        let css = "body{-webkit-user-select:none;-webkit-user-drag:none;}"
        // CSS选中样式取消
        var jsStr = "var style = document.createElement('style');"
        jsStr.append("style.type = 'text/css';")
        jsStr.append("var cssContent = document.createTextNode('\(css)');")
        jsStr.append("style.appendChild(cssContent);")
        jsStr.append("document.body.appendChild(style);")
        jsStr.append("document.documentElement.style.webkitUserSelect='none';") /// 禁止选择
        //        jsStr.append("document.documentElement.style.webkitTouchCallout='none';") /// 禁止长按
                
                let noMunuScript = WKUserScript(source: jsStr, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.javaScriptEnabled = true
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        
        config.userContentController = WKUserContentController()
  //      config.userContentController.add(self, name: <#前端给的参数#>)
        
        config.userContentController.addUserScript(userScript)
        config.userContentController.addUserScript(noMunuScript)
        
        let webV = WKWebView(frame: CGRect.zero, configuration: config)
        webV.scrollView.showsVerticalScrollIndicator = false
        webV.scrollView.bounces = false
        webV.allowsLinkPreview = false//是否支持链接预览
        webV.uiDelegate = self
        webV.allowsBackForwardNavigationGestures = true
        return webV
    }()
    
    lazy private var progressV: UIProgressView = {
        let progress = UIProgressView(frame: CGRect(x: 0, y: 0, width: Metric.screenW, height: 2))
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }

    
    deinit{
        
        wkWebV.removeObserver(self, forKeyPath: "estimatedProgress",context: &Metric.myContext)
        wkWebV.scrollView.removeObserver(self, forKeyPath: "contentSize",context: nil)
        print("JYWWKWebViewController.deinit")
    }
}

extension JYWWKWebViewController {
    // MARK:- ---加载ui---
    private func initUI(){
        //禁止侧滑
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //wkWebView
        wkWebV.navigationDelegate = self
        wkWebV.frame = view.bounds
        //监听wkwebview的contentsize以自适应大小
        wkWebV.scrollView.addObserver(self, forKeyPath: "contentSize", options: [.new], context: nil)
        view.addSubview(wkWebV)
        
        //
        let maskView = UIView(frame: CGRect(x: 0, y: 0, width: Metric.screenW, height: Metric.statusH))
        maskView.backgroundColor = .black
        view.addSubview(maskView)
        
        //progress
        view.addSubview(progressV)
        progressV.isHidden = true
        //kvo
        wkWebV.addObserver(self, forKeyPath: "estimatedProgress", options: [.old, .new], context: &(Metric.myContext))

    }
    
    // TODO:- ---进度条消失动画---
    private func hideProgress(){
        UIView.animate(withDuration: Metric.hideDuration) {
            self.progressV.progress = 0
            self.progressV.isHidden = true
        }
    }
    
    // TODO:- ---加载h5字符串---
    private func loadHTML5Str(htmlStr: String?) {
        guard var h5Str = htmlStr else {return}
        h5Str = h5Str.replacingOccurrences(of: "&lt;", with: "<")
        h5Str = h5Str.replacingOccurrences(of: "&quot;", with: "\"")
        h5Str = h5Str.replacingOccurrences(of: "&gt;", with: ">")
        h5Str = h5Str.replacingOccurrences(of: "&amp;", with: "&")
        let styleStr = "<style>img{width:100%;height:auto;}</style>"
        let htmlFormat = "<!DOCTYPE html> <html lang=\"cn\"> <head> <meta charset=\"utf-8\"> %@ <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"> <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\"> </head> <body> %@ </body> </html>"
        let htmlContent = String(format: htmlFormat, styleStr, h5Str)
        
        self.wkWebV.loadHTMLString(htmlContent, baseURL: URL(string: ""))
    }
}

extension JYWWKWebViewController: WKNavigationDelegate {
    
    // MARK:- ---进度条---
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &Metric.myContext{
            progressV.progress = Float(wkWebV.estimatedProgress)
        }
        
        //wkwebview contentsize大小
        if keyPath == "contentSize" {
//            let fittingSize = wkWebV.scrollView.contentSize
//            if fittingSize != lastContentSize {
//                lastContentSize = fittingSize
//                print("wkGaodu:\(fittingSize)")
//                wkWebV.frame = CGRect(x: 0, y: adaptW(70.0), width: kScreenW, height: fittingSize.height)
//                self.tableHeaderV?.frame = CGRect(x: 0, y: 0, width: kScreenW, height: fittingSize.height + adaptW(70.0))
//                // 添加动画
//                tableview.beginUpdates()
//                tableview.tableHeaderView = self.tableHeaderV!
//                tableview.endUpdates()
//            }
        }
    }
    
    // MARK:- ---wkDelegate---
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
        hideProgress()
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("返回内容")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
        
        hideProgress()
    }
}

extension JYWWKWebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

//        if message.name == <#前端给的参数#>{
//
//        }
    }

}

//Mark: - 弹窗处理
extension JYWWKWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "确认", style: .default) { (action) in
            completionHandler()
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "确认", style: .default) { (action) in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            completionHandler(false)
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertVC = UIAlertController(title: "提示", message: prompt, preferredStyle: .alert)
        alertVC.addTextField { (tf) in
            tf.text = defaultText
        }
        let okAction = UIAlertAction(title: "完成", style: .default) { (action) in
            completionHandler(alertVC.textFields?[0].text == nil ? nil:"");
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: false, completion: nil)
    }
}
