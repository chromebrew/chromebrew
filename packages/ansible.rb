require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation platform from RedHat.'
  homepage 'https://www.ansible.com/'
  version '2.9.14-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://releases.ansible.com/ansible/ansible-2.9.14.tar.gz'
  source_sha256 'efe7183e08f0c9dd9efd9124efa8978be62851b1e8eb856593a073538bfc6fb5'

  depends_on 'py3_jinja2'
  depends_on 'py3_pyyaml'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
