require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.6.4'
  source_url 'https://releases.ansible.com/ansible/ansible-2.6.4.tar.gz'
  source_sha256 'e06b795372fd7a6d0b46b8f105497fb637fbd323f5aec1d8e51fd60cd98047e1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a29e99dd2d25ab1e80e689bf47e9e35345770fee14db6c7aee7b3f131ef6943f',
     armv7l: 'a29e99dd2d25ab1e80e689bf47e9e35345770fee14db6c7aee7b3f131ef6943f',
       i686: '6442bd5ce2678ce8a1ef4936661def66eca16c77d0baf06ad745401ac6ede5f6',
     x86_64: '896e3f1a1feae460d917aad223f01ea07b4fcd74728965fc26ee1a6cc24cea98',
  })

  depends_on 'setuptools'

  def self.install
    system "TMPDIR=#{CREW_PREFIX}/tmp \
            pip install --prefix #{CREW_PREFIX} \
            --root #{CREW_DEST_DIR} -I ansible==2.6.4"
  end
end
