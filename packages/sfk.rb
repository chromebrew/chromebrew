require 'package'

class Sfk < Package
  description 'The Swiss File Knife - A Command Line Tools Collection for Windows / Linux / Mac.'
  homepage 'http://swissfileknife.sourceforge.net/'
  version '1.8.7'
  source_url 'https://sourceforge.net/projects/swissfileknife/files/1-swissfileknife/1.8.7/sfk-1.8.7.tar.gz'
  source_sha256 '1c53d4d9d05af752546c8341a718bf64be99b62491ff91db02ef100e2f93bfc3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sfk-1.8.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sfk-1.8.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sfk-1.8.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sfk-1.8.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '66de7a4de3b92fad4a4e68df7fbedf6318f0576f98f3bbcd2be6bfa5026638f8',
     armv7l: '66de7a4de3b92fad4a4e68df7fbedf6318f0576f98f3bbcd2be6bfa5026638f8',
       i686: 'ba2504cdbfa127dddfeea0ce1d39d60cf0a06e8c1f9eda0c14870db9c53ba755',
     x86_64: '714260e8edd3bac91f3a034e896ac36626f0dc4ec7f6a7ec4a88dfb7617ebc5b',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

