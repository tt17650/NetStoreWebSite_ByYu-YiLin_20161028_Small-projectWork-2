<%@ WebHandler Language="C#" Class="MyFavorite" %>

using System;
using System.Web;

public class MyFavorite : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");

        //讀取Cookie: myFavorite
        if (context.Request.Cookies["myFavorite"] == null) {
            //尚未設定我的最愛:引導至首頁
            context.Response.Redirect("Default.aspx");
        }
        else {
            //讀取書(產品)的編號
            string tid = context.Request.Cookies["myFavorite"].Value;
            string url = string.Format("Detail.aspx?qid={0}",tid); //格式化字串，將取得的編號與詳細資料頁(Detail.aspx)的qid做結合
            context.Response.Redirect(url); //引導至url字串頁面
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}