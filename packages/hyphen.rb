require 'package'

class Hyphen < Package
  description 'hyphenation library to use converted TeX hyphenation patterns'
  homepage 'https://github.com/hunspell/hyphen'
  version '73dd29'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hyphen/archive/73dd2967c8e1e4f6d7334ee9e539a323d6e66cbd.tar.gz'
  source_sha256 'd174ba8a2653e79ebd135fd2241fe87d511f9510a31e82bdf13ec21192852595'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/hyphen-73dd29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/hyphen-73dd29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/hyphen-73dd29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/hyphen-73dd29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9c4dc3e8175ecf54eff33dca64506534b0a5e284749854ff20fc8f2b411c2442',
     armv7l: '9c4dc3e8175ecf54eff33dca64506534b0a5e284749854ff20fc8f2b411c2442',
       i686: 'a7a0146e845bdb5238a2f30bfca98261e4c1cc509f0f70a0a457092ad6a50346',
     x86_64: '6bb5f68a9f8b03a56456c9e806a9baf6be49ee2298bbc0c0e0c4ef182152f79b',
  })

  def self.build
    system 'autoreconf -fvi'
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
