using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// CartItem 的摘要描述
/// </summary>
public class CartItem {
    //public CartItem() {
    //    //
    //    // TODO: 在這裡新增建構函式邏輯
    //    //
    //}
    public string Product_Id { get; set; }//編號
    public string ProductName { get; set; } //產品名稱
    public decimal Price { get; set; } //價格
    public int Quantity { get; set; } //數量
    public decimal SubTotal { //小計
        get {
            return this.Price * this.Quantity;
        }
    }
}