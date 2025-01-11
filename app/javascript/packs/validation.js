$(document).on('turbolinks:load', function () {
    $('sign-up-id').validate({
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
               maxlength: 129,
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
                maxlength: 'パスワードは129文字以内で入力して下さい',
            },
            
            'user[password-confirmation]': {
                required: 'パスワード確認を入力して下さい',
                equalTo: 'パスワードが一致しません',
            }
       },
       errorElement: 'div',
       errorClass: 'text-danger',
       highlight: function (element) {
           $(element).addClass('.is_invalid');
       },
       unhighlight: function (element) {
           $(elemet).removeClass('.is_invalid');
       },
    });
});