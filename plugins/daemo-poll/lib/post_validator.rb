module DaemoPoll
  class PostValidator
    def initialize(post)
      @post = post
    end

    def validate_post
      min_trust_level = SiteSetting.daemo_poll_minimum_trust_level_to_create
      trusted = @post&.user&.staff? ||
                @post&.user&.trust_level >= TrustLevel[min_trust_level]

      if !trusted
        message = I18n.t("daemo_poll.insufficient_rights_to_create")

        @post.errors.add(:base, message)
        return false
      end

      true
    end
  end
end
