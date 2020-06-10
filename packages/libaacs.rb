require 'package'

class Libaacs < Package
  description 'This library is simply a tool for playback of Blu-ray movies.'
  homepage 'https://www.videolan.org/developers/libaacs.html'
  version '0.9.0'
  compatibility 'all'
  source_url 'https://get.videolan.org/libaacs/0.9.0/libaacs-0.9.0.tar.bz2'
  source_sha256 '47e0bdc9c9f0f6146ed7b4cc78ed1527a04a537012cf540cf5211e06a248bace'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libaacs-0.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libaacs-0.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libaacs-0.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libaacs-0.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '79d13f5b1aa9dcf1f00d982a96a4756ca71a743e488141f29f57b7752c28d335',
     armv7l: '79d13f5b1aa9dcf1f00d982a96a4756ca71a743e488141f29f57b7752c28d335',
       i686: '7c5b65877429795ac1c0a772799bb79f7adf81f577a29744db418c42b7483e8d',
     x86_64: '704e13a05f7b35053df356eec8185dc09f7437265255a7c517e203ebb3ea9848',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
