require 'active_record'
require 'WhereIs_model'

class Location < ActiveRecord::Base
  belongs_to :member
  # geocoded_by :address
  # reverse_geocoded_by :latitude, :longitude
  # after_validation :geocode, if: :address_changed?
  # after_validation :reverse_geocoded, if: :latitude_changed? or :longitude_changed?
end


