Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = "."
    d.has_ssh = true
  end

  config.ssh.private_key_path = "./private.key"
  config.ssh.port = 22
  config.ssh.shell = "bash --login"

  #override.vm.box = nil

end
