using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class NetStoreMembership {
    //1.由類別圖檢視幫忙產生的方法
    //public bool CreateUser(string username, string password, out string errMessage) {
    //    throw new System.NotImplementedException();
    //}

    //2.寫入基本程式碼
    //public bool CreateUser(string username, string password, out string errMessage) {
    //    bool result = false;
    //    errMessage = string.Empty;
    //    //加入會員
    //    return result;
    //}

    //3.加入ADO.NET實體資料模型(建立Entity Framework)(檢查檔案及套件package)

    //4.寫入功能程式碼
    public static bool CreateUser(string username, string password, out string errMessage) {
        bool result = false;
        errMessage = string.Empty;

        //設定會員資料
        Member member = new Member();
        member.Username = username;
        member.HashPassword = GenHash(password);

        try {
            //加入至會員資料表
            NetStoreDBEntities1 db = new NetStoreDBEntities1();  //NetStoreDBEntities1 為NetStoreModels.edmx中的"實體容器名稱"屬性
            db.Members.Add(member);
            db.SaveChanges();
            result = true;
        }
        catch(Exception ex) {
            errMessage = ex.Message;
        }

        return result;
    }
    static string GenHash(string password) {
        string salt = BCrypt.Net.BCrypt.GenerateSalt(12);
        string hash = BCrypt.Net.BCrypt.HashPassword(password, salt);
        return hash;
    }
    public static bool VerifyUser(string username, string password) {

        //取得資料庫中使用者對應的HashPass
        string hashDb = "";
        NetStoreDBEntities1 db = new NetStoreDBEntities1();  //NetStoreDBEntities1 為NetStoreModels.edmx中的"實體容器名稱"屬性
        Member user = db.Members.Find(username);
        if (user == null) { //會員不存在
            return false;
        }
        else {
            hashDb = user.HashPassword;
        }

        //比對
        return BCrypt.Net.BCrypt.Verify(password, hashDb);
    }
}