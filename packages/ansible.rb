require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.6.2'
  source_url 'https://releases.ansible.com/ansible/ansible-2.6.2.tar.gz'
  source_sha256 '747e4cca09c10833ffe3a7c53af310d2d387bd4f499ec6e1bde60662606aaff8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27'

  def self.install
    system 'pip install setuptools'
    system "python2.7 setup.py build"
    system "python2.7 setup.py install --root=#{CREW_DEST_DIR}"
    system "pip install Jinja2 --target=#{CREW_DEST_DIR}"
    system "pip install PyYAML --target=#{CREW_DEST_DIR}"
    system "pip install paramiko --target=#{CREW_DEST_DIR}"
    system "pip install cryptography --upgrade --target=#{CREW_DEST_DIR}"
    system 'pip uninstall -y setuptools'
  end
end
