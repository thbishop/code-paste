class Parser < ActiveRecord::Base
  has_many :pastes

  validates_uniqueness_of :name
  validates_uniqueness_of :display_name
  validates_presence_of :name
  validates_presence_of :display_name

  def self.lang_counts
    lang_cnt = {}
    Parser.includes(:pastes).each do |parser|
      lang_cnt[parser.display_name] = parser.pastes.size
    end

    lang_cnt
  end
end
