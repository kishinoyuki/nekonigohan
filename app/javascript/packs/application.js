import $ from "jquery";
import "jquery-validation";

console.log("validation.js loaded");

$(document).on("turbolinks:load", function () {
  console.log("Turbolinks loaded");

  const form = $("#sign-up-id");
  const submitButton = form.find('input[type="submit"]'); // 新規登録ボタン

  if (form.length > 0) {
    const validator = form.validate({
      rules: {
        "user[name]": { required: true, minlength: 2, maxlength: 20 },
        "user[email]": { required: true, email: true },
        "user[password]": { required: true, minlength: 6 },
        "user[password_confirmation]": { required: true, equalTo: "#user_password" },
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
        toggleSubmitButtonState(); // ボタンの状態を切り替え
      },
      unhighlight: function (element) {
        $(element).removeClass("is-invalid");
        $(element).siblings(".invalid-feedback").html(""); // エラークリア
        toggleSubmitButtonState(); // ボタンの状態を切り替え
      },
      errorPlacement: function (error, element) {
        const feedbackElement = element.siblings(".invalid-feedback");
        if (feedbackElement.length > 0) {
          feedbackElement.html(error); // 既存のエラーメッセージを更新
        } else {
          element.after(error); // デフォルトの位置にエラーを追加
        }
      },
    });

    // ボタンの状態を切り替える関数
    function toggleSubmitButtonState() {
      const hasErrors = form.find(".is-invalid").length > 0; // is-invalidが存在するか
      submitButton.prop("disabled", hasErrors); // エラーがある場合に無効化
    }

    // 初期状態での検証
    form.find("input").each(function () {
      const element = this;
      const valid = $(element).valid(); // 各フィールドを検証
      if (!valid) {
        $(element).addClass("is-invalid");
      }
    });

    // 初期状態でボタンの状態を切り替え
    toggleSubmitButtonState();
  }
  
  const loginForm = $("#sign-in-id");
  const loginSubmitButton = loginForm.find('input[type = "submit"]');
  
  if (loginForm.length > 0) {
    const loginValidator = loginForm.validate ({
      rules: {
        "user[email]": {required: true, email: true},
        "user[password]": {required: true},
      },
      
      messages: {
        "user[email]": {
          required: "メールアドレスを入力して下さい",
          email: "正しいメールアドレスを入力して下さい",
        },
        "user[password]": {
          required: "パスワードを入力して下さい",
        },
      },
      errorElement: "div",
      errorClass: "invalid-feedback",
      highlight: function (element) {
        $(element).addClass("is-invalid");
        toggleSubmitButtonState();
      },
      unhighlight: function (element) {
        $(element).removeClass("is-invalid");
        toggleSubmitButtonState();
      },
      errorPlacement: function (error, element) {
        const feedbackElement = element.siblings(".invalid-feedback");
        if (feedbackElement.length > 0) {
          feedbackElement.html(error);
        } else {
          element.after(error);
        }
      },
    });
    
    function toggleSubmitButtonState() {
      const hasErrors = loginForm.find(".is-invalid").length > 0;
      loginSubmitButton.prop("disabled", hasErrors);
    }
    
    loginForm.find("input").each(function () {
      const element = this;
      const valid = $(element).valid();
      if (!valid) {
        $(element).addClass("is-invalid");
      }
    });
    toggleSubmitButtonState();
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
