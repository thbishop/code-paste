Factory.define :parser do |par|
  par.display_name ''
  par.name ''
end

Factory.define :paste do |pas|
  pas.code ''
end

Factory.define :rails_snip, :class => 'paste' do |snip|  
  snip.code "class Paste < ActiveRecord::Base\r\n  belongs_to :parser\r\n  before_validation :calc_num_of_lines\r\n  \r\n  def line_numbers\r\n    doc = get_parsed_code\r\n    \r\n    lin_num = ''\r\n    \r\n    doc.xpath('//pre').each do |root|\r\n      root.children.each do |n|\r\n        if n['class'] == 'line-numbers'\r\n          lin_num += n.content.strip + \"\\n\"\r\n        end\r\n      end\r\n    end\r\n    \r\n    return lin_num    \t\t  \r\n  end\r\n  \r\n  def highlighted_code\r\n    doc = get_parsed_code\r\n    \r\n    hcode = \"\"\r\n    \r\n    doc.xpath('//pre').each do |root|\r\n      if root['class'] == 'twilight'\r\n        root['id'] = 'source-code'\r\n      end\r\n      \r\n      root.children.each do |n|\r\n        if n['class'] == 'line-numbers'\r\n          n.unlink\r\n        end\r\n      end\r\n    end\r\n    \r\n    return doc\r\n  end\r\n  \r\n  private\r\n  def get_parsed_code\r\n    parsed_output = Uv.parse(self.code, 'xhtml', self.parser.name, true, 'blackboard')\r\n    doc = Nokogiri::HTML(parsed_output)    \r\n  end\r\n  \r\n  def calc_num_of_lines\r\n    doc = get_parsed_code\r\n    \r\n    lin_num = ''\r\n    \r\n    doc.xpath('//pre').each do |root|\r\n      root.children.each do |n|\r\n        if n['class'] == 'line-numbers'\r\n          lin_num = ''\r\n          lin_num += n.content.strip\r\n        end\r\n      end\r\n    end\r\n    \r\n    self.number_of_lines = lin_num.to_i\r\n  end\r\n  \r\nend\r\n"
  # p.association :parser, :factory => :rails_parser
  snip.parser {|p| p.association :parser, :name => 'ruby_on_rails', :display_name => 'Ruby on Rails' }
end

Factory.define :xml_snip, :class => 'paste' do |snip|
  # def snip.default_parent
  #     @default_parent ||= Factory(:parser, :name => 'xml', :display_name => 'XML')
  # end
  snip.code "<note>\r\n <to>Tov</to>\r\n  <from>Jani</from>\r\n <heading>Reminder</heading>\r\n <body>Don't forget me this weekend!</body>\r\n  </note>"
  # snip.parser {|p| p.association :xml_parser }
  snip.parser {|p| p.association :parser, :name => 'xml', :display_name => 'XML' }
  # snip.parser_id { snip.default_parent.id }
end

Factory.define :perl_snip, :class => 'paste' do |snip|
  snip.code "package Net::GitHub::V2::Network;\r\n\r\nuse Any::Moose;\r\n\r\nour $VERSION = '0.07';\r\nour $AUTHORITY = 'cpan:FAYLAND';\r\n\r\nuse URI::Escape;\r\n\r\nwith 'Net::GitHub::V2::HasRepo';\r\n\r\nsub network_meta {\r\n   my ( $self ) = @_;\r\n\r\n    my $owner = $self->owner;\r\n   my $repo = $self->repo;\r\n\r\n   my $url = \"http://github.com/$owner/$repo/network_meta\";\r\n    my $json = $self->get($url);\r\n    return $self->json->jsonToObj($json);\r\n }\r\n\r\n sub network_data_chunk {\r\n    my ( $self, $net_hash, $start, $end ) = @_;\r\n\r\n   my $owner = $self->owner;\r\n   my $repo = $self->repo;\r\n\r\n   my $url = \"http://github.com/$owner/$repo/network_data_chunk?nethash=$net_hash\";\r\n    $url .= \"&start=$start\" if defined $start;\r\n    $url .= \"&end=$end\" if defined $end;\r\n    my $json = $self->get($url);\r\n    return $self->json->jsonToObj($json);\r\n   }\r\n\r\n no Any::Moose;\r\n  __PACKAGE__->meta->make_immutable;\r\n\r\n  1;"
  snip.parser {|p| p.association :parser, :name => 'perl', :display_name => 'Perl' }
end