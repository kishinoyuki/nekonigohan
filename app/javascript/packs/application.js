import $ from "jquery";
window.$ = window.jQuery = $;
import "jquery-validation";

console.log("validation.js loaded");

$(document).on("turbolinks:load", function () {
  console.log("Turbolinks loaded");

  const form = $("#sign-up-id");
  if (form.length > 0) {
    form.validate({
      rules: {
        "user[name]": {
          required: true,
          minlength: 2,
          maxlength: 20,
        },
        "user[email]": {
          required: true,
          email: true,
        },
        "user[password]": {
          required: true,
          minlength: 6,
        },
        "user[password_confirmation]": {
          required: true,
          equalTo: "#user_password",
        },
      },
      messages: {
        "user[name]": {
          required: "ニックネームを入力して下さい",
          minlength: "ニックネームは2文字以上で入力して下さい",
          maxlength: "ニックネームは20文字以内で入力して下さい",
        },
        "user[email]": {
          required: "メールアドレスを入力して下さい",
          email: "正しいメールアドレスを入力して下さい",
        },
        "user[password]": {
          required: "パスワードを入力して下さい",
          minlength: "パスワードは６文字以上で入力して下さい",
        },
        "user[password_confirmation]": {
          required: "パスワード確認を入力して下さい",
          equalTo: "パスワードが一致しません",
        },
      },
      errorElement: "div",
      errorClass: "invalid-feedback",
      highlight: function (element) {
        $(element).addClass("is-invalid");
      },
      unhighlight: function (element) {
        $(element).removeClass("is-invalid");
      },
      errorPlacement: function (error, element) {
        element.siblings(".invalid-feedback").append(error);
      },
      onkeyup: function (element) {
        const valid = $(element).valid();
        if (valid) {
          $(element).removeClass("is-invalid");
        } else {
          $(element).addClass("is-invalid");
        }
      },
      onblur: function (element) {
        const valid = $(element).valid(); 
        if (valid) {
          $(element).removeClass("is-invalid");
        } else {
          $(element).addClass("is-invalid");
        }
      },
    });
  }
});

import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import Raty from "raty.js";
window.raty = function (elem, opt) {
  let raty = new Raty(elem, opt);
  raty.init();
  return raty;
};

Rails.start();
Turbolinks.start();
ActiveStorage.start();
