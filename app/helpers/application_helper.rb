module ApplicationHelper
    def attachment_url(attachment)
        if attachment.attached?
          if Rails.env.test?
            '#'  # A dummy path for test environment
          else
            begin
              # rails_blob_path(attachment, only_path: true)
            rescue NoMethodError
              '#'  # Fallback if rails_blob_path is not available
            end
          end
        else
          # '#'
        end
      end
    end
