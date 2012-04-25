module MarkupTransform
  module HtmlStrip
    extend ActiveSupport::Concern
    include ActionView::Helpers::SanitizeHelper

    private

    def strip_html(text)
      strip_tags(text)
    end
  end
end