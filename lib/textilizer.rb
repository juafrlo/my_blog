class Textilizer
  def initialize(text)
    @text = text
  end
  
  def to_html
    RedCloth.new(formatted_text).to_html
  end
  
  
  # Post body must have this format:
  # @@@ ruby
  # Some code
  # @@@
  def formatted_text    
    @text.gsub(/^@@@ ?(\w*)\r?\n(.+?)\r?\n@@@\r?$/m) do |match|
      lang = $1.empty? ? nil : $1
      "notextile. #{CodeRay.scan($2, lang).div(:css => :class)}"
    end
  end
end