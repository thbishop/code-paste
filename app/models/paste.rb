class Paste < ActiveRecord::Base
  belongs_to :parser
  
  def line_numbers
    parsed_output = Uv.parse(self.code, 'xhtml', self.parser.name, true, 'twilight')
    doc = Nokogiri::HTML(parsed_output)
    
    lin_num = ""
    
    doc.xpath('//pre').each do |root|
      root.children.each do |n|
        if n['class'] == 'line-numbers'
          lin_num += n.content + "\n"
        end
      end
    end
    
    return lin_num    		  
  end
  
  def highlighted_code
    parsed_output = Uv.parse(self.code, 'xhtml', self.parser.name, true, 'twilight')
    doc = Nokogiri::HTML(parsed_output)
    
    hcode = ""
    
    doc.xpath('//pre').each do |root|
      root.children.each do |n|
        if n['class'] != 'line-numbers'
          hcode += n.to_s
        end
      end
    end
    
    return code
  end
  
end
