class ManageIQ::Providers::Lenovo::PhysicalInfraManager < ManageIQ::Providers::InfraManager
  has_many :physical_servers, 
           foreign_key => "ems_id", 
           class_name => "ManageIQ::Providers::Lenovo::PhysicalInfraManager::PhysicalServer"

  include ManageIQ::Providers::Lenovo::ManagerMixin
  include_concern 'Operations'

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

  def turn_on_loc_led(args, options = {})
    $lenovo_log.info("Turn on LED splat (connect) #{args} #{options}")

    ems_auth = authentications.first
    $lenovo_log.info(" USer: #{ems_auth.userid}, Host: #{endpoints.first.hostname}")
    @connection = connect(:user => ems_auth.userid, 
                          :pass => ems_auth.password, 
                          :host => endpoints.first.hostname)
    @connection.turn_on_loc_led(args.uuid)
    $lenovo_log.info("Turn on LED splat (no connect)")
  end
end
