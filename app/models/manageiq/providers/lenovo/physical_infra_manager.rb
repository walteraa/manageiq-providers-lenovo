class ManageIQ::Providers::Lenovo::PhysicalInfraManager < ManageIQ::Providers::InfraManager
  has_many :physical_servers, foreign_key: "ems_id", class_name: "ManageIQ::Providers::Lenovo::PhysicalInfraManager::PhysicalServer"

  include ManageIQ::Providers::Lenovo::ManagerMixin

  require_nested :Refresher
  require_nested :RefreshParser
  require_nested :EventCatcher
  require_nested :EventParser
  require_nested :RefreshWorker

  def self.ems_type
    @ems_type ||= "lenovo_ph_infra".freeze
  end

  def self.description
    @description ||= "Lenovo XClarity"
  end

  def turn_on_loc_led(server, options = {})
    # Connect to the LXCA instance
    auth = authentications.first
    endpoint = endpoints.first
    client = connect({:user => auth.userid,
                      :pass => auth.password,
                      :host => endpoint.hostname})

    # Turn on the location LED using the xclarity_client API
    client.turn_on_loc_led(server.uuid)
  end

  def turn_off_loc_led(server, options = {})
    # Connect to the LXCA instance
    auth = authentications.first
    endpoint = endpoints.first
    client = connect({:user => auth.userid,
                      :pass => auth.password,
                      :host => endpoint.hostname})

    # Turn off the location LED using the xclarity_client API
    client.turn_off_loc_led(server.uuid)
  end
end
