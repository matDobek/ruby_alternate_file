module AlternateFileStrategy
  class Minitest
    class << self
      def dir_mapping
        {
          "app" => "/test/",
          "lib" => "/test/lib/",
        }
      end

      def template
        <<~HEREDOC
          require "test_helper"

          class Test < ActiveSupport::TestCase
          end
        HEREDOC
      end
    end
  end
end
