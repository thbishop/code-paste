# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
{ 'CSS' => 'css',
  'HTML' => 'html',
  'HTML (ERB/Rails)' => 'html_rails',
  'Java' => 'java',
  'Javascript' => 'javascript',
  'JSON' => 'json',
  'Perl' => 'perl',
  'Plain Text' => 'plain_text',
  'Ruby' => 'ruby',
  'Ruby on Rails' => 'ruby_on_rails',
  'XML' => 'xml',
  'YAML' => 'yaml'
}.each_pair { |k,v|
  @parser = Parser.find_by_display_name(k)
  Parser.create!(:display_name => k, :name => v) unless @parser
}
