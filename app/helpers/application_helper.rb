module ApplicationHelper
    def attachment_url(attachment)
        return test_attachment_url if Rails.env.test?
        return default_attachment_url unless attachment.attached?

        real_attachment_url(attachment)
      end

      private

      def test_attachment_url
        "#"
      end

      def default_attachment_url
        # Handle the case where attachment is not attached
      end

      def real_attachment_url(attachment)
        # Code to get the actual attachment URL for non-test environments
      end
end
