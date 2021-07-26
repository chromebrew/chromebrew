require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '3.3.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://files.pythonhosted.org/packages/53/d5/6cdea3c8479644b1b788d57cad500e9d782e06f6a84cac05121a65cca67e/ansible-3.3.0.tar.gz'
  source_sha256 '2de5385c48a2a24a19f6cbaccc7d7684c64b6194f9a9b175aba7949d53b07bc9'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ansible/3.3.0_i686/ansible-3.3.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ansible/3.3.0_x86_64/ansible-3.3.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: 'df3f907db3401d10f4b302a2c899e18271c963e1d92ea9cdfa14e70e9d4986fe',
  x86_64: 'c1580c511f0ae42bf3aacce66439ce8c9cf2f93c4ebe40223ae65410e88b3b22'
  })

  depends_on 'ansible_base'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
