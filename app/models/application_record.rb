class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def recursive_symbolize_keys! hash
    hash.symbolize_keys!
    hash.values.select{|v| v.is_a? Hash}.each{|h| recursive_symbolize_keys!(h)}
  end
end
