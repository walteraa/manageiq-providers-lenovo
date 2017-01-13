module ManageIQ::Providers::Lenovo::PhysicalInfraManager::Operations
  extend ActiveSupport::Concern

  def power_on(args, options = {})
    change_resource_state(:power_on_node, args, options)
  end

  def power_off(args, options = {})
    change_resource_state(:power_off_node, args, options)
  end

  def restart(args, options = {})
    change_resource_state(:power_restart_node, args, options)
  end

  private

  def change_resource_state(verb, args, _options = {})
    $lenovo_log.info("Entering change resource state for #{verb} and uuid: #{args.uuid}")
    ems_auth = authentications.first
    @connection = connect(:user => ems_auth.userid,
                          :pass => ems_auth.password,
                          :host => endpoints.first.host)
    @connection.send(verb, args.uuid)
    $lenovo_log.info("Exiting change resource state for #{verb} and uuid: #{args.uuid}")
  end
end
