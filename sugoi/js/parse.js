<script type="text/javascript">
Parse.initialize("FMpOZ3pGmgoKxs5eAkml0W4JOItxcNSxykrBLFTO", "Pi563TSPHTQVHDAbMXol07FxJIhORBljv8HJRDHb");


var Cardclass = Parse.Object.extend("CardClass");
var query = new Parse.Query(Cardclass);
query.get("HVXSFQM6CH", {
  success: function(Cardclass) {
    // The object was retrieved successfully.
    var number = Cardclass.get("cardNumber");
    //document.write("Card Number: " + number);
    var date = Cardclass.get("expirationDate");
    //document.write("<br>Expiration Date: " + date);
    var security = Cardclass.get("securityCode");
    //document.write("<br>CVV: "+ security);

  },
  error: function(object, error) {
    // The object was not retrieved successfully.
    // error is a Parse.Error with an error code and message.
  }
});
