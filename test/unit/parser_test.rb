require 'test_helper'

class ParserTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should validate_presence_of :display_name

  context "with an existing parser" do
    setup do
      Factory.create(:parser, :name => 'xml', :display_name => 'XML')
    end

    should validate_uniqueness_of :name
    should validate_uniqueness_of :display_name
  end

  context "a new parser" do
    setup do
      @parser_count = Parser.count
      Factory.create(:parser, :name => 'xml', :display_name => 'XML')
    end

    should "increase our parser count by 1" do
      assert Parser.count == @parser_count + 1
    end
  end

  context "three existing parsers, each with pastes" do
    setup do
      @xml_par = Factory.create(:parser, :name => 'xml', :display_name => 'XML')
      @rails_par = Factory.create(:parser, :name => 'ruby_on_rails', :display_name => 'Ruby on Rails')
      @perl_par = Factory.create(:parser, :name => 'perl', :display_name => 'Perl')

      4.times do
        Factory.create(:xml_snip, :parser => @xml_par)
      end

      3.times do
        Factory.create(:rails_snip, :parser => @rails_par)
      end

      2.times do
        Factory.create(:perl_snip, :parser => @perl_par)
      end
    end

    should "return counts of related pastes" do
      lang_paste_counts = { 'Perl' => 2,
                            'Ruby on Rails' => 3,
                            'XML' => 4
                          }

      assert_equal lang_paste_counts, Parser.lang_counts
    end
  end

end
