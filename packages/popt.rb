require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '78ebda3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rpm-software-management/popt.git'
  git_hashtag '78ebda342ca9bec60e4dd5f1d5b720dade3ab4b2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/78ebda3_armv7l/popt-78ebda3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/78ebda3_armv7l/popt-78ebda3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/78ebda3_i686/popt-78ebda3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/popt/78ebda3_x86_64/popt-78ebda3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2ba47ce5e9cf8493c82d371da80dc4e5a0e0d7bc0cf36996781b089d01e3b8d1',
     armv7l: '2ba47ce5e9cf8493c82d371da80dc4e5a0e0d7bc0cf36996781b089d01e3b8d1',
       i686: '611be7ffbadab77c9da3492f13fbc8860522ec01adefbfbb462fb9c1afc76530',
     x86_64: '591ff491561a48dc2a993b718a554dc303fab823929dc622963d6144db6e5fe1'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
