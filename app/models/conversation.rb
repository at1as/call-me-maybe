require 'phonelib'
require 'sidekiq/api'

class Conversation < ApplicationRecord
  default_scope -> { order(start_time: :desc) }

  # after_save :queue_alert_jobs # TODO
  before_destroy :destroy_pending_user_jobs

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :guest_email, presence: true
  validates :start_time, presence: true
  validates_format_of :guest_email, :with => VALID_EMAIL, :on => :create, :allow_blank => false
  validates :phonenumber, phone: { possible: true, allow_blank: true }
  

  TARGETED_DELETION_JOBS = %w[SmsReminderJob MailVideoUrlJob].freeze

  private
    def destroy_pending_user_jobs
      scheduled = Sidekiq::ScheduledSet.new
      scheduled.each do |job|
        if TARTED_DELETION_JOBS.include?(job.args.first["job_class"]) && job.args.first["arguments"].include?("conversation_id=#{self.id}")
          job.delete
        end
      end
    end
end
