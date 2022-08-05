require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.8-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-6.8.tar.xz'
  source_sha256 '8eb753ed28bca21f8f56c1a180362aed789229bd62fff58bf8368e9beb59fec4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8-1_armv7l/texinfo-6.8-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8-1_armv7l/texinfo-6.8-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8-1_i686/texinfo-6.8-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/6.8-1_x86_64/texinfo-6.8-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b74885ef4051db9e1706e77f7ec58747ad1f4de3901c08f28831b07fd7f0f6b4',
     armv7l: 'b74885ef4051db9e1706e77f7ec58747ad1f4de3901c08f28831b07fd7f0f6b4',
       i686: '1a199141340ffa01dcb0287e590ad5844f70ce1dc9b5df9459df486aec420ce0',
     x86_64: '6a6c3c50dfbd0fbc32552308d45ba48cf44e55fd7c29563aabbaefa9b3726bfe'
  })

  depends_on 'perl'
  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'

  def self.build
    # configure and make
    # LDflags set to workaround i686 build issues.
    @ldflags = ''
    @ldflags = 'LDFLAGS=-static' if ARCH == 'i686'
    system "#{@ldflags} ./configure #{CREW_OPTIONS} \
      --with-external-Text-Unidecode \
      --with-external-Unicode-EastAsianWidth"
    # Fix broken i686 build.
    system "sed -i 's/-static//' info/Makefile" if ARCH == 'i686'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
