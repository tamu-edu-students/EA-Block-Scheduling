class State < ApplicationRecord
  def expired?
    expires_at.present? && expires_at <= Time.now
  end
end
