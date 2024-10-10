require 'package'

class Libassuan < Package
  description 'Libassuan is a small library implementing the so-called Assuan protocol.'
  homepage 'https://www.gnupg.org/related_software/libassuan/index.html'
  version '3.0.1'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-#{version}.tar.bz2"
  source_sha256 'c8f0f42e6103dea4b1a6a483cb556654e97302c7465308f58363778f95f194b1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '37cede2c044d520214d52cea89f713b430f23ca5b0ad89168d197de4bedf1ea6',
     armv7l: '37cede2c044d520214d52cea89f713b430f23ca5b0ad89168d197de4bedf1ea6',
       i686: '01b982b4968c5d8402e13504ecb253d3fd78ce8cbc006c21e3877c33bf3330c3',
     x86_64: '22a5df7a07a95e6d3c70925f668bdd5cab66ef28caaa967b823b3368354ca012'
  })

  depends_on 'libgpg_error'

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "env CFLAGS='-flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
