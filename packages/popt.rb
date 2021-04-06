require 'package'

class Popt < Package
  description 'Library for parsing command line options'
  homepage 'https://directory.fsf.org/wiki/Popt'
  version '1.18'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/rpm-software-management/popt/archive/popt-#{version}-release.tar.gz"
  source_sha256 '36245242c59b5a33698388e415a3e1efa2d48fc4aead91aeb2810b4c0744f4e3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/popt-1.18-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e301538c274369121eb26cf77d91d1a5c451cc4ec088a115361c1b31175a06c8',
     armv7l: 'e301538c274369121eb26cf77d91d1a5c451cc4ec088a115361c1b31175a06c8',
       i686: '8017bb16b0ee0094e66d1a130734463389721d060b31340b47ce5e2a2521ea4b',
     x86_64: 'b6f09b9dcca99c16e61a7c71333ce0454c38ad99c7dfa0893cce9c44f8335f77'
  })

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "gzip -9 #{CREW_DEST_PREFIX}/share/man/man3/popt.3"
  end
end
