require 'package'

class Alsa_utils < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - utilities'
  homepage 'https://github.com/alsa-project/alsa-utils'
  version '1.2.2'
  compatibility 'all'
  source_url 'https://github.com/alsa-project/alsa-utils/archive/v1.2.2.tar.gz'
  source_sha256 '9da1ce4f12a4dd56d55cd5a8f6ae7d56ac91397c3d37fdfcd737adeeb34fce1c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_utils-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cff8b1579f0d7b918ac5f9bfb7dd3e6bfb4f4beff4eb28eae425add13b1c0ee2',
     armv7l: 'cff8b1579f0d7b918ac5f9bfb7dd3e6bfb4f4beff4eb28eae425add13b1c0ee2',
       i686: '27c3a3394bcadf2751fbeb755b269cedbd078349638b64e3febdf1ef7c468ad9',
     x86_64: '31deca395175c3c5fde640609bb635a1a35a329fe840c63fd2c280462e82d7d7',
  })

  depends_on 'alsa_lib'

  def self.build
    system "./gitcompile --prefix=#{CREW_PREFIX}"
  end

  def self.check
    # This takes several hours to run!
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
