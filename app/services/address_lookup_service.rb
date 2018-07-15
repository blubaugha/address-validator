class AddressLookupService
  attr_accessor :address

  def initialize(address)
    @address = address
  end

  def lookup
    credentials = SmartyStreets::StaticCredentials.new(
        Rails.application.secrets.smarty_streets_auth_id,
        Rails.application.secrets.smarty_streets_auth_token
    )
    client = SmartyStreets::ClientBuilder.new(credentials).build_us_street_api_client
    lookup = SmartyStreets::USStreet::Lookup.new
    lookup.street = @address.street_address
    lookup.city = @address.city
    lookup.state = @address.state
    lookup.zipcode = @address.zip_code

    begin
      client.send_lookup(lookup)
    rescue SmartyStreets::SmartyError => err
      #TODO: Add better exception handling, or just let this bubble up
      puts err
      return
    end

    result = lookup.result

    if result.empty?
      return
    end

    components = result[0].components

    {
        house_number: components.primary_number,
        street_name: components.street_name,
        street_type: components.street_suffix,
        street_predirection: components.street_predirection,
        street_postdirection: components.street_postdirection,
        unit_number: components.secondary_number,
        unit_type: components.secondary_designator,
        city: components.city_name,
        state: components.state_abbreviation,
        zip_5: components.zipcode,
        zip_4: components.plus4_code
    }
  end
end
