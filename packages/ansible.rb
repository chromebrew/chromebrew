require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.8.5'
  source_url 'https://releases.ansible.com/ansible/ansible-2.8.5.tar.gz'
  source_sha256 '8e9403e755ce8ef27b6066cdd7a4c567aa80ebe2fd90d0ff8efa0a725d246986'

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
