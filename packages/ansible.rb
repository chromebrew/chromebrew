require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.9.14'
  compatibility 'all'
  source_url 'https://releases.ansible.com/ansible/ansible-2.9.14.tar.gz'
  source_sha256 'efe7183e08f0c9dd9efd9124efa8978be62851b1e8eb856593a073538bfc6fb5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.9.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.9.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.9.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.9.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9c43a7e52691b4ba2042a34fc5613db34d45b8b3dbe96aeb8754b296fca9437a',
     armv7l: '9c43a7e52691b4ba2042a34fc5613db34d45b8b3dbe96aeb8754b296fca9437a',
       i686: 'f93312f9080369044f136abf3713e54b490efe1833d9ba6ca8959b3300f57de9',
     x86_64: '03858df7d32282cbc04bcf33ec923e3ea03963898be7d0d6fdb51e589e43f11f',
  })

  depends_on 'setuptools'

  def self.install
    system "TMPDIR=#{CREW_PREFIX}/tmp \
            pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} -I ansible==#{self.version}"
  end
end
