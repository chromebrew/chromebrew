require 'package'

class Sane_backends < Package
  description 'Scanner Access Now Easy - Backends'
  homepage 'http://www.sane-project.org/'
  version '1.0.32'
  license 'GPL-2 and public-domain'
  compatibility 'all'
  source_url 'https://gitlab.com/sane-project/backends/uploads/104f09c07d35519cc8e72e604f11643f/sane-backends-1.0.32.tar.gz'
  source_sha256 '3a28c237c0a72767086202379f6dc92dbb63ec08dfbab22312cba80e238bb114'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/sane_backends-1.0.32-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/sane_backends-1.0.32-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/sane_backends-1.0.32-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/sane_backends-1.0.32-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ac5d7ac8a77796e58a2b423ecabb59df5cbcec5c734080942cf187517deecaf9',
     armv7l: 'ac5d7ac8a77796e58a2b423ecabb59df5cbcec5c734080942cf187517deecaf9',
       i686: '5fad9e3f62a984238d46ce0eb4a3e29bb687a38c7fc356c8a058c9fe242395e5',
     x86_64: '977124535b8365b80a29d6449f22cb0760f417f294f341ec53ebd9faae2c4cab'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
