Vagrant.configure(2) do |config|
  BOX_NAME="lnpm-magento"
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.network "private_network", type: "dhcp"

  # Hostnamager configuration
  config.hostmanager.enabled           = true
  config.hostmanager.manage_host       = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline   = false

  # Dinamic ip resolver for vagrant hostmanager plugin
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      begin
          buffer = '';
          vm.communicate.execute("/sbin/ifconfig") do |type, data|
            buffer += data if type == :stdout
          end

          ips = []
          ifconfigIPs = buffer.scan(/inet addr:(\d+\.\d+\.\d+\.\d+)/)
          ifconfigIPs[0..ifconfigIPs.size].each do |ip|
              ip = ip.first

              next unless system "ping -c1 -t1 #{ip} > /dev/null"

              ips.push(ip) unless ips.include? ip
          end

          ips.first
      rescue StandardError => exc
          return
      end
  end

  config.vm.define 'lnpm-magento' do |node|
    node.vm.hostname = 'lnpm-magento.loc'
  end;

  # avoid possible request "vagrant@127.0.0.1's password:" when "up" and "ssh"
  config.ssh.password = "vagrant"

  config.vm.provision :shell, :path => "install-1404.sh"
end
