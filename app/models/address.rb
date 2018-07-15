class Address < ApplicationRecord
  attr_accessor :lookup_result, :street_address, :zip_code

  validates :house_number, presence: {message: 'House number is required'}
  validates :street_name, presence: {message: 'Street name is required'}
  validates :city, presence: {message: 'City is required'}
  validates :state, presence: {message: 'State is required'}
  validates :zip_5, presence: {message: 'A 5-digit zip code is required'},
            format: {with: /[\d]{5}/, message: 'Zip code must be 5 digits'}

  before_validation :lookup
  validate :verify_exists

  def lookup
    if should_validate
      @lookup_result = AddressLookupService.new(self).lookup
      self.attributes = @lookup_result if @lookup_result
    end
  end

  def verify_exists
    if should_validate && @lookup_result.nil?
      errors.add(:not_exist, "The address '#{street_address} #{city} #{state} #{zip_code}' does not exist")
    end
  end

  def should_validate
    @street_address && @zip_code
  end

  def to_s
    # TODO: override the to_s method so that it prints out the address components as follows
    # house_number street_predirection street_name street_type street_postdirection unit_type unit_number, city, state zip_5

    home_and_street = [
        house_number,
        street_predirection,
        street_name,
        street_type,
        street_postdirection,
        unit_type,
        unit_number
    ].compact.join(' ')

    "#{home_and_street}, #{city}, #{state} #{zip_5}"
  end
end
