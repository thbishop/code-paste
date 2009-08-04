class Parser < ActiveRecord::Base
  has_many :pastes
  
  validates_uniqueness_of :name
  validates_uniqueness_of :display_name
  validates_presence_of :name
  validates_presence_of :display_name
  
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
