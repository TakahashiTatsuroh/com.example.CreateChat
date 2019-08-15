//
//  LoginViewController.swift
//  CreateChat
//
//  Created by 高橋達朗 on 2019/08/15.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }

}


extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //エラーがないか確認
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        //ユーザーの認証情報取得
        let authentication = user.authentication
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication!.idToken, accessToken: authentication!.accessToken)
        
        //Googleアカウントを使って、Firebaseにログイン情報を登録
        Auth.auth().signIn(with: credential) { (AuthDataResult, error) in
            if let err = error {
                print("ログインに失敗しました")
                print(err.localizedDescription)
            } else {
                print("ログインに成功しました")
            }
        }
        
    }
    
    
}



