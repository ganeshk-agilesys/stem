module MarkupTransform
  class BbCodify

    def initialize(html)
      html ||= ''

      #remove windows linefeeds
      html.gsub!(/\r/, '')

      #remove excessive spaces
      html.gsub!(/( |&nbsp;)+/, ' ')

      @direction = :bottom_up
      @html = Loofah.fragment(html)
    end

    def to_s
      bbcode = HTMLEntities.new.decode(@html.dup.scrub!(MarkupTransform::BbCodify::Scrubber.new).to_s)

      #remove empty b tag nodes
      bbcode.gsub!(/\[b\]\[\/b\]/, "")

      #remove trailing spaces
      bbcode.gsub!(/ ?\n ?/, "\n")

      #remove remaining excessive newlines
      bbcode.gsub!(/\n{2,}/, "\n\n")

      bbcode.strip
    end

    class Scrubber < Loofah::Scrubber

      def initialize
        @direction = :bottom_up
      end

      def scrub(node)
        return CONTINUE if node.text?
        replacement_killer = \
          case node.name
          when "h1", "h2", "h3", "h4"
            new_text node, "\n[b]#{node.content.strip}[/b]\n"
          when "b", "strong"
            new_text node, "[b]#{node.content.strip}[/b]"
          when "span", "font"
            new_text node, node.content # not stripping on purpose as this isnt a block element and could validly contain trailing spaces
          when "li"
            new_text node, "[li]#{node.content.strip}[/li]"
          when "ul"
            new_text node, "\n[ul]#{node.content.strip}[/ul]\n"
          when "ol"
            new_text node, "\n[ol]#{node.content.strip}[/ol]\n"
          when "code"
            new_text node, node.content
          when "br"
            new_text node, "\n"
          when "img"
            new_text node, "[img]#{node['src']}[/img]"
          when "a"
            if node['href'].nil?
              new_text node, node.content
            else
              new_text node, "[url=#{node['href']}]#{node.text.strip}[/url]"
            end
          else
            if Loofah::Elements::BLOCK_LEVEL.include?(node.name)
              new_text node, "\n#{node.content.strip}\n"
            else
              nil
            end
          end
        if replacement_killer
          node.add_next_sibling replacement_killer
          node.remove
        end
      end

      private

      def new_text(node, text)
        Nokogiri::XML::Text.new(text, node.document)
      end

      def end_of_doc(node)
        (node.document.serialize_root || node.ancestors.last).children.last
      end
    end
  end
end