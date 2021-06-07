import 'stylesheets/readers.css'

const $ = window.$;

$((event) => {
  $(".btn.btn-buy a").click(event => {
    const modalId = $(event.target).data("modal-id");
    const successCallback = function (message) {
      if ($(`#${modalId}`).length < 1) {
        $("body").append(message);
        var myModal = new bootstrap.Modal(document.getElementById(modalId), {
          keyboard: false
        })
        myModal.show();
      } else if ($(`#${modalId}`).length == 1) {
        var myModal = new bootstrap.Modal(document.getElementById(modalId), {
          keyboard: false
        })
        myModal.show();
      }
    }
    const request_obj = {
      dataType: 'html',
      accepts: {
        json: "text/html"
      },
      url: event.target.href,
      type: "GET", 
      success: successCallback
    }
    $.ajax(request_obj);
    return false;
  })

  $(event => {
    $("h2.accordion-header button.accordion-button").click(event => {
      const itemId = $(event.target).data("bs-target");
      console.log($(itemId)[0]);
      if ($(itemId).hasClass("show")) {
        alert(true);
        $(itemId).hide();
      }
    })
  })

  $(event => {
    $(".btn.btn-return").click(event => {
      console.log(event.target);
      const successCallback = function (message) {
        console.log(message);
        $(event.target).html('RETURNED THIS BOOK');
      }
      const request_obj = {
        dataType: 'json',
        accepts: {
          json: "application/json"
        },
        url: event.target.href,
        type: "POST", 
        success: successCallback
      }
      $.ajax(request_obj);
      return false;
    })
  })
});