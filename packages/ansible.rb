require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.4.3'
  source_url 'http://releases.ansible.com/ansible/ansible-2.4.3.0.tar.gz'
  source_sha256 '0e98b3a56928d03979d5f8e7ae5d8e326939111b298729b03f00b3ad8f998a3d'

  depends_on 'python27'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I ansible==2.4.3"
    system "yes | pip uninstall setuptools"
  end
end
