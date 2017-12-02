require 'package'

class Avocado < Package
  description 'Avocado is a next generation testing framework inspired by Autotest and modern development tools such as git.'
  homepage 'http://avocado-framework.github.io/'
  version '55.0'
  source_url 'https://github.com/avocado-framework/avocado/archive/55.0.tar.gz'
  source_sha256 '0ec798afaca0910d7b3853aa8a7782c4d95e54bbf5ff8473005bcd70829e5a9f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-55.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-55.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-55.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/avocado-55.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b3ac4e192ca4bfbcb1edd6748468da4c478ed34567e6d458972915d34ebbcb16',
     armv7l: 'b3ac4e192ca4bfbcb1edd6748468da4c478ed34567e6d458972915d34ebbcb16',
       i686: '412ac4c79f809aedb1b95385607799f21396b198d6fe2bffbd5322d09b6cb2c9',
     x86_64: '40e334f809c80e1ac0bda9608b662d266356ba12da148080c99aa68cc8788a01',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/pip"
  depends_on 'xzutils'

  def self.install
    system "pip install avocado-framework --root #{CREW_DEST_PREFIX} --prefix #{CREW_DEST_PREFIX}"
    system "pip install -r https://raw.githubusercontent.com/avocado-framework/avocado/master/requirements.txt --root #{CREW_DEST_PREFIX} --prefix #{CREW_DEST_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}/usr/libexec #{CREW_DEST_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}/usr/share #{CREW_DEST_PREFIX}"
    system "mv #{CREW_DEST_PREFIX}#{CREW_DEST_PREFIX}/* #{CREW_DEST_PREFIX}"
    system "rm -rf #{CREW_DEST_PREFIX}#{CREW_PREFIX}/tmp"
    system "mkdir -p $HOME/.config/avocado"
    system "ln -s #{CREW_PREFIX}/etc/avocado/avocado.conf $HOME/.config/avocado/avocado.conf"
    system "mkdir -p #{CREW_DEST_DIR}/$HOME/.config/avocado"
    system "ln -s #{CREW_PREFIX}/etc/avocado/avocado.conf #{CREW_DEST_DIR}/$HOME/.config/avocado/avocado.conf"
  end
end
