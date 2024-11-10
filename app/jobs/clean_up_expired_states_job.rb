# app/jobs/clean_up_expired_states_job.rb

class CleanUpExpiredStatesJob < ApplicationJob
  queue_as :default

  def perform(*)
    State.where('expires_at <= ?', Time.now).delete_all
  end
end
