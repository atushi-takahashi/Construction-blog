module NotificationsHelper
  def notification_user_form(notification)
    @visiter = notification.visiter
    @visited = notification.visited
    @comment = nil
    your_post = link_to 'あなたの投稿', post_path(notification), style: "font-weight: bold;"
    your_question = link_to 'あなたの質問', question_path(notification), style: "font-weight: bold;"
    @visiter_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when "follow"
      tag.a(notification.visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "があなたをフォローしました"
    when "post_like"
      tag.a(notification.visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にいいねしました"
    when "question_like"
      tag.a(notification.visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの質問', href: question_path(notification.question_id), style: "font-weight: bold;") + "にいいねしました"
    when "post_comment"
      # @comment = Comment.find_by(id: @visiter_comment)&.message
      tag.a(@visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にコメントしました"
    when "question_comment"
      # @comment = Comment.find_by(id: @visiter_comment)&.message
      tag.a(@visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの質問', href: question_path(notification.question_id), style: "font-weight: bold;") + "にコメントしました"
    when "dm"
      tag.a(@visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "から" + tag.a('ダイレクトメッセージ', href: room_path(notification.room_id), style: "font-weight: bold;") + "が届いています"
    end
  end

  def notification_admin_form(notification)
    @visiter = notification.visiter
    @visited = notification.visited
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when "post_report"
      tag.a(@visiter.name, href: admins_user_path(@visiter), style: "font-weight: bold;") + "さんが" + tag.a(@visited.name, href: admins_user_path(@visited), style: "font-weight: bold;") + "さんの" + tag.a('記事', href: admins_post_path(notification.post_id), style: "font-weight: bold;") + "を" + tag.a('通報', href: admins_report_path(notification.report_id), style: "font-weight: bold;") + "しました"
    when "question_report"
      tag.a(@visiter.name, href: admins_user_path(@visiter), style: "font-weight: bold;") + "さんが" + tag.a(@visited.name, href: admins_user_path(@visited), style: "font-weight: bold;") + "さんの" + tag.a('記事', href: admins_question_path(notification.question_id), style: "font-weight: bold;") + "を" + tag.a('通報', href: admins_report_path(notification.report_id), style: "font-weight: bold;") + "しました"
    end
  end
end
