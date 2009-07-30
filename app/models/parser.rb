class Parser < ActiveRecord::Base
  has_many :pastes
  
  def self.lang_counts
    lang_cnt = {}
    parsers = Parser.all.map(&:display_name)
    
    parsers.sort.each { |parser|
      @parser = Parser.find(:first, :conditions => ["display_name = ?", parser])
      
      lang_cnt[parser] = @parser.pastes.size
    }
    
    return lang_cnt
  end
end
