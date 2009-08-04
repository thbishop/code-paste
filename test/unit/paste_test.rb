require 'test_helper'

class PasteTest < ActiveSupport::TestCase
  should_belong_to :parser  
  should_validate_presence_of :code
  should_validate_presence_of :number_of_lines
  should_validate_numericality_of :number_of_lines
  
  context "a new paste" do
    setup do
      @par = Factory.create(:parser, :name => 'xml', :display_name => 'XML')
      @paste = Factory.create(:paste, :code => "<note>\r\n <to>Tov</to>\r\n  <from>Jani</from>\r\n <heading>Reminder</heading>\r\n <body>Don't forget me this weekend!</body>\r\n  </note>", :parser => @par)
    end
    
    should "have the correct parser" do
      assert_equal 'xml', @paste.parser.name
    end

    should "have the correct number of lines" do
      assert_equal 6, @paste.number_of_lines
    end
    
    should "have a code summary" do
      assert_equal @paste.code, @paste.code_summary(10)
    end
    
    should "have a highlighted code attribute" do
      assert_not_nil @paste.highlighted_code
    end
  end
end
