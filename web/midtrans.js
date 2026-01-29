function payMidtrans(snapToken) {
  window.snap.pay(snapToken, {
    onSuccess: function(result) {
      console.log("SUCCESS", result);
    },
    onPending: function(result) {
      console.log("PENDING", result);
    },
    onError: function(result) {
      console.log("ERROR", result);
    },
    onClose: function() {
      console.log("CLOSED");
    }
  });
}
