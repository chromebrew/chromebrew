require 'package'

class Ansible < Package
  description 'Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.'
  homepage 'https://www.ansible.com/'
  version '2.5.0'
  source_url 'http://releases.ansible.com/ansible/ansible-2.5.0.tar.gz'
  source_sha256 '714ede4b0f5455eb2dd2536d8cabb42ab439f52b5ac902308ad027b46f68e6dc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ansible-2.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1101f5205b7310836e095922340ce1d69986d3292e8b354184baef265eb7548e',
     armv7l: '1101f5205b7310836e095922340ce1d69986d3292e8b354184baef265eb7548e',
       i686: '2631c1e1b83dfd75021c8dcc28e2301bb267ac1be95857bbe60cab91fcb0b44c',
     x86_64: 'd588644e26d4b54daf55b921914dd2f32ee67ddef7277af89b9726f729cc7f1c',
  })

  depends_on 'python27'

  def self.build
    system "yes | pip install setuptools"
    system "python2 setup.py build"
  end

  def self.install
    system "python2 setup.py install --root=#{CREW_DEST_DIR}"
  end
  
  def self.postinstall
    puts "Check and install dependencies ...".lightblue
    system "yes | pip install ansible"
  end
end
