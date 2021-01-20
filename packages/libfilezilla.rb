require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.26'
  compatibility 'all'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.26.0.tar.bz2'
  source_sha256 '17ed226593e8e466ce3c3f8ce583b36c79f163189ead54d631613cc3da5c80bd'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libfilezilla-0.26-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '7f2ff4e1a1f55bac7e9450fc0d85f84ec21ec2a62f2c45c02c6342c7670dbfd3',
      armv7l: '7f2ff4e1a1f55bac7e9450fc0d85f84ec21ec2a62f2c45c02c6342c7670dbfd3',
        i686: 'd07c70bf760ed003bf5d2365ae23bb5adc4da0091aa07b69eaa14b5e9d27ee97',
      x86_64: '982dbdceeeb0889dc516156785218bf520d25e1e1602cada0523f6cc7f14774e',
  })


  depends_on 'p11kit'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
