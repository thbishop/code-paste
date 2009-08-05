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
  Parser.create!(:display_name => k, :name => v)
}
