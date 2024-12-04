module NotificationsHelper
    def notification_message(notification)
        case notification.notifiable_type
        when "Post"
            "フォローしている#{notification.notifiable.user.name}さんが新しいレビューを投稿しました！"
        else
            "投稿した#{notification.notifiable.post.title}が#{notification.notifiable.user.name}さんにブックマークされました！"
        end
    end
end
