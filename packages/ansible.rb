require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.5.4'
  source_url 'https://releases.ansible.com/ansible/ansible-2.5.4.tar.gz'
  source_sha256 '33a76684c47d1857d6e917af4f2eafac87521161f8181037edaa159a60deaeb3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '41f0441eec7e74b4b21861052bde53ce43a7b22a2b9c68c676f896dfb480169a',
     armv7l: '41f0441eec7e74b4b21861052bde53ce43a7b22a2b9c68c676f896dfb480169a',
       i686: '43248e68218b109aed78c9433437f87c17d91ed7157e48a8ee14afc8b317d6d7',
     x86_64: '79da8f120e498ab28ab3dbb94645ab005c5ab78e5e9cb4b2c7639e72792ee97f',
  })

  depends_on 'python27'

  def self.install
    system 'pip install setuptools'
    system "TMPDIR=#{CREW_PREFIX}/tmp pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I ansible==2.5.4"
    system 'pip uninstall -y setuptools'
  end
end
