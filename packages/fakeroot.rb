require 'package'

class Fakeroot < Package
  description 'Run a command in an environment faking root privileges for file manipulation.'
  homepage 'https://wiki.debian.org/FakeRoot'
  version '1.25.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/f/fakeroot/fakeroot_1.25.3.orig.tar.gz'
  source_sha256 '8e903683357f7f5bcc31b879fd743391ad47691d4be33d24a76be3b6c21e956c'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '92c44951d47177c59c5afcb0f58a9628e469f4f29586e85ace47eb84bbfddbe7',
     armv7l: '92c44951d47177c59c5afcb0f58a9628e469f4f29586e85ace47eb84bbfddbe7',
       i686: 'b689d26d69b8760b6a083d4119c8240aa26a6d4cf7efb70fd547901badd29ad2',
     x86_64: 'df77a7108f6dfc836eda895fed8c7b84274828af41d0e5e4eaa1d1ca0ba0cf9d'
  })

  depends_on 'libcap'

  def self.patch
    # Needed since build fails when building other language
    # manpages.
    system "sed -i '/SUBDIRS/d' doc/Makefile.am"
  end

  def self.build
    system './bootstrap'
    system "env CFLAGS='-flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
