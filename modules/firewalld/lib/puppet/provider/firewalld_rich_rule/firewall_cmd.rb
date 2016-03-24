require 'puppet'

Puppet::Type.type(:firewalld_rich_rule).provide :firewall_cmd do
  desc "Interact with firewall-cmd"


  commands :firewall_cmd => 'firewall-cmd'

  mk_resource_methods

  
  def exists?
    @rule_args ||= build_rich_rule
    args=['--permanent', '--zone',@resource[:zone],'--query-rich-rule',"'#{@rule_args}'"].join(' ')
    %x{ /usr/bin/firewall-cmd #{args} }
    $?.success?
  end

  def quote_keyval(key,val)
    val ? "#{key}=\"#{val}\"" : ''
  end

  def key_val_opt(opt, resource_param=opt)
    quote_keyval(opt, @resource[resource_param.to_s])
  end

  def eval_source
    args=[]
    return [] unless addr = @resource[:source]
    args << quote_keyval('source address', addr['address'])
    args << quote_keyval('invert', addr['invert'])
    args
  end
  
  def eval_dest
    args=[]
    return [] unless addr = @resource[:dest]
    args << quote_keyval('destination address',addr['address'])
    args << quote_keyval('invert', addr['invert'])
    args
  end

  def elements
   [ :service, :port, :protocol, :icmp_block, :masquerade, :forward_port ]
  end

  def eval_element
    args=[]
    element = elements.select { |e| resource[e] }.first
    args << element.to_s.gsub(/_/,'-')
    case element
    when :service
      args << quote_keyval('name', @resource[:service])
    when :port
      args << quote_keyval('port', @resource[:port]['port'])
      args << quote_keyval('protocol', @resource[:port]['protocol'])
    when :icmp_block
      args << quote_keyval('name', @resource[:icmp_block])
    when :masquerade
    when :forward_port
      args << quote_keyval('port',     @resource[:forward_port]['port'])
      args << quote_keyval('protocol', @resource[:forward_port]['protocol'])
      args << quote_keyval('to-port',  @resource[:forward_port]['to_port'])
      args << quote_keyval('to-addr',  @resource[:forward_port]['to_addr'])
    end
    args
  end

  def eval_log
    return [] unless @resource[:log]
    args = []
    args << 'log'
    if @resource[:log].is_a?(Hash) 
      args << quote_keyval('prefix', @resource[:log]['prefix'])
      args << quote_keyval('level', @resource[:log]['level'])
      args << quote_keyval('limit value', @resource[:log]['limit'])
    end
    args
  end

  def eval_audit
    return [] unless @resource[:audit]
    args = []
    args << 'audit'
    if @resource[:audit].is_a?(Hash) 
      args << quote_keyval('limit value', @resource[:log]['limit'])
    end
    args
  end

  def eval_action
    return [] unless action = @resource[:action]
    args=[]
    if action.is_a?(Hash)
      args << action[:action]
      args << quote_keyval('type', action[:type])
    else
      args << action
    end
  end

  def build_rich_rule
    return @resource[:raw_rule] if @resource[:raw_rule]
    rule = [ 'rule' ]
    rule << [
      key_val_opt('family'),
      eval_source,
      eval_dest,
      eval_element,
      eval_log,
      eval_audit,
      eval_action,
    ]
    @resource[:raw_rule] = rule.flatten.reject { |r| r.empty? }.join(" ")
    @resource[:raw_rule]
  end

  def firewall_cmd_run(opt)
      args = []
      args << [ '--permanent', '--zone', @resource[:zone] ]
      args << opt
      args << "'#{@resource[:raw_rule]}'"
      output = %x{/usr/bin/firewall-cmd #{args.flatten.join(' ')} 2>&1}
      raise Puppet::Error, "Failed to run firewall rule: #{output}" unless $?.success?
      output = %x{/usr/bin/firewall-cmd --reload 2>&1}
      raise Puppet::Error, "Failed to reload firewall rule: #{output}" unless $?.success?
  end

  def create
    firewall_cmd_run('--add-rich-rule')
  end

  def destroy
    firewall_cmd_run('--remove-rich-rule')
  end


end

