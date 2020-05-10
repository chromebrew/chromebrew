require 'package'

class Bleachbit < Package
  description 'Clean Your System and Free Disk Space'
  homepage 'https://www.bleachbit.org/'
  version '2.2'
  compatibility 'all'
  source_url 'https://download.bleachbit.org/bleachbit-2.2.tar.bz2'
  source_sha256 '0318cd1bc83655971c9ffd6bf27f4866bbe57381e92cfbcf8a2a6833075b49fa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bleachbit-2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bleachbit-2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bleachbit-2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bleachbit-2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2afa292475e4b51d8a05be4c9d22053e07b0ab9fc80f15c31206a7c76196b1b8',
     armv7l: '2afa292475e4b51d8a05be4c9d22053e07b0ab9fc80f15c31206a7c76196b1b8',
       i686: '2db04756504e73dc5045016a45a7fa2ebeeab506aed80b5eb9a552db73e211dd',
     x86_64: 'cb0083062191290a8182fa14f43310e2dc43f583d4d9e20d6aad99a7ade8dabc',
  })

  depends_on 'pygtk'
  depends_on 'sommelier'

  def self.patch
    system "for f in \$(grep -lrn '/usr/share'); do sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' \$f; done"
  end

  def self.build
    system 'make -C po local'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config/bleachbit"
    system "touch #{CREW_DEST_HOME}/.config/bleachbit/bleachbit.ini"
    system 'make', "prefix=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
