require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.8.5'
  compatibility 'all'
  source_url 'https://releases.ansible.com/ansible/ansible-2.8.5.tar.gz'
  source_sha256 '8e9403e755ce8ef27b6066cdd7a4c567aa80ebe2fd90d0ff8efa0a725d246986'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.8.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.8.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.8.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.8.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f98e84a4761b65b27d666496d9c73a20c94994072af69faa1b29e189b51b37a',
     armv7l: '0f98e84a4761b65b27d666496d9c73a20c94994072af69faa1b29e189b51b37a',
       i686: '19569f4ab9b9b11a753a88cd12eb2650266931b91443679c49a119eeeb52932d',
     x86_64: 'da437a69b68b9fa6a24d449cec83e09141dcb8f28a8098de01d0b652bfebc2b3',
  })

  depends_on 'setuptools'

  def self.install
    system "TMPDIR=#{CREW_PREFIX}/tmp \
            pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} -I ansible==#{self.version}"
  end
end
