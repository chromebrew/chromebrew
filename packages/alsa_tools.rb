require 'package'

class Alsa_tools < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - tools'
  homepage 'https://github.com/alsa-project/alsa-tools'
  version '1.2.2'
  source_url 'https://github.com/alsa-project/alsa-tools/archive/v1.2.2.tar.gz'
  source_sha256 '7242cfb3493461b2a28c9c3a6a69dbc2e9ee236a5dc46400cbb0d1d87c27b453'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_tools-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_tools-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_tools-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_tools-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '13e8a8e05816e7b33369a3dfa62805d74a31899aac172f2d895e181c002e163c',
     armv7l: '13e8a8e05816e7b33369a3dfa62805d74a31899aac172f2d895e181c002e163c',
       i686: '1ca6fa11e786e0d277ff15532de6b58f9a1bba5198163fc7d773ecddbabe4574',
     x86_64: '9078e54a91c60bb12d5f8087239cf21b24b033f04991e095f22502d663a5d77c',
  })

  depends_on 'alsa_lib'
  depends_on 'fltk'
  depends_on 'gtk2'

  def self.patch
    # Make sure automake can be found.
    system "find -name gitcompile -exec sed -i 's,/usr/local/share/automake,#{CREW_PREFIX}/share/automake-1.16,' {} +"
    # Take out things that won't build.
    system "sed -i 's,ld10k1 qlo10k1,,' Makefile"
    system "sed -i 's,usx2yloader,,' Makefile"
    system "sed -i 's,hdspmixer,,' Makefile" if ARCH != 'x86_64'
  end

  def self.build
    system "GITCOMPILE_ARGS='--prefix=#{CREW_PREFIX}' make all"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
