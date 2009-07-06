class Paste < ActiveRecord::Base
  belongs_to :parser
  before_validation :calc_num_of_lines
  
  def line_numbers
    doc = get_parsed_code
    
    lin_num = ''
    
    doc.xpath('//pre').each do |root|
      root.children.each do |n|
        if n['class'] == 'line-numbers'
          lin_num += n.content.strip + "\n"
        end
      end
    end
    
    return lin_num    		  
  end
  
  def highlighted_code
    doc = get_parsed_code
    
    hcode = ""
    
    doc.xpath('//pre').each do |root|
      if root['class'] == 'twilight'
        root['id'] = 'source-code'
      end
      
      root.children.each do |n|
        if n['class'] == 'line-numbers'
          n.unlink
        end
      end
    end
    
    return doc
  end
  
  private
  def get_parsed_code
    parsed_output = Uv.parse(self.code, 'xhtml', self.parser.name, true, 'twilight')
    doc = Nokogiri::HTML(parsed_output)    
  end
  
  def calc_num_of_lines
    doc = get_parsed_code
    
    lin_num = ''
    
    doc.xpath('//pre').each do |root|
      root.children.each do |n|
        if n['class'] == 'line-numbers'
          lin_num = ''
          lin_num += n.content.strip
        end
      end
    end
    
    self.number_of_lines = lin_num.to_i
  end
  
end
