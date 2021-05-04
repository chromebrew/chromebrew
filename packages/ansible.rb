require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '3.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/53/d5/6cdea3c8479644b1b788d57cad500e9d782e06f6a84cac05121a65cca67e/ansible-3.3.0.tar.gz'
  source_sha256 '2de5385c48a2a24a19f6cbaccc7d7684c64b6194f9a9b175aba7949d53b07bc9'

  depends_on 'ansible_base'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
