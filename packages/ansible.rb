require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.9.14'
  compatibility 'all'
  source_url 'https://releases.ansible.com/ansible/ansible-2.9.14.tar.gz'
  source_sha256 'efe7183e08f0c9dd9efd9124efa8978be62851b1e8eb856593a073538bfc6fb5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'setuptools'

  def self.install
    system "TMPDIR=#{CREW_PREFIX}/tmp \
            pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} -I ansible==#{self.version}"
  end
end
