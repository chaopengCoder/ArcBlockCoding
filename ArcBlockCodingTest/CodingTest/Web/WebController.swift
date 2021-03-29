//
//  WebController.swift
//  ArcBlockCodingTest
//
//  Created by chaopengCoder on 2021/3/28.
//

import Foundation
import WebKit

class WebController: UIViewController {
    
    fileprivate let url: String
    
    fileprivate lazy var iWebView: WKWebView = {
        let wk = WKWebView()
        wk.navigationDelegate = self
        return wk
    }()
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        
        loadUrl(url: self.url)
    }
    
    fileprivate func setupSubviews() {
        view.addSubview(iWebView)
        iWebView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func loadUrl(url: String) {
        if url.isUrlFormat {
            guard let url = URL(string: url) else { return }
            iWebView.load(URLRequest(url: url))
        } else {
            let alert = UIAlertController(title: "提示", message: "链接无效", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "知道了", style: .default, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension WebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
}
