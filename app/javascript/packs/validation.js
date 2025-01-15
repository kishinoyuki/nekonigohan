console.log('validation.js loaded');

$(document).ready(function () {
    console.log('テスト');
    $('#sign-up-id').validate({
       rules: {
           'user[name]': {
               required: true,
               minlength: 2,
               maxlength: 20
           },
           
           'user[email]': {
               required: true,
               email: true
           },
           
           'user[password]': {
               required: true,
               minlength: 6,
           },
           
           'user[password-confirmation]': {
               required: true,
               equalTo: '#user_password',
           },
       },
       
       messages: {
            'user[name]': {
                required: 'ニックネームを入力して下さい',
                minlength: 'ニックネームは2文字以上で入力して下さい',
                maxlength: 'ニックネームは20文字以内で入力して下さい',
            },
            
            'user[email]': {
                required: 'メールアドレスを入力して下さい',
                email: '正しいメールアドレスを入力して下さい',
            },
            
            'user[password]': {
                required: 'パスワードを入力して下さい',
                minlength: 'パスワードは６文字以上で入力して下さい',
            },
            
            'user[password-confirmation]': {
                required: 'パスワード確認を入力して下さい',
                equalTo: 'パスワードが一致しません',
            }
       },
       
       errorElement: 'div',
       errorClass: 'invalid-feedback',
       highlight: function (element) {
           $(element).addClass('is-invalid');
       },
       unhighlight: function (element) {
           $(element).removeClass('is-invalid');
       },
       
       errorPlacement: function (error, element) {
           console.log('エラーメッセージ:', error);  // エラーメッセージが出力されるか確認
           console.log('エラーを挿入する要素:', element);
           element.closest('.form-group').append(error);
       },
       
       onkeyup: function (element) {
           $(element).valid();
       },
       
       onblur: function (element) {
           $(element).valid();
       }
    });
});