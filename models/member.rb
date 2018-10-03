require 'active_record'
require 'WhereIs_model'

class Member < ActiveRecord::Base
  has_many :locations, :dependent => :delete_all
  scope :newest_location, -> (id) {Member.find(id).locations.order(:time).last.place}
  scope :newest_time, -> (id) {Member.find(id).locations.order(:time).last.time}
end



