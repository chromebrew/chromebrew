require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '7.0.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-7.0.3.tar.xz'
  source_sha256 '74b420d09d7f528e84f97aa330f0dd69a98a6053e7a4e01767eed115038807bf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3_armv7l/texinfo-7.0.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3_armv7l/texinfo-7.0.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3_i686/texinfo-7.0.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0.3_x86_64/texinfo-7.0.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '477c405025570b2e6b723af86c5931b0d6e5e1df424d4d0e712ea0bd46c84aac',
     armv7l: '477c405025570b2e6b723af86c5931b0d6e5e1df424d4d0e712ea0bd46c84aac',
       i686: 'eabbfd13da1d8b08bfb0f06c729054db098ed708b9443410432250fc9a660697',
     x86_64: 'd9fa00e921ebef6d30fe29005b404656c1b698e97b5a46d10408d1ebf71a5a4f'
  })

  depends_on 'glibc' # R
  depends_on 'perl'
  depends_on 'perl_locale_messages'
  depends_on 'perl_text_unidecode'
  depends_on 'perl_unicode_eastasianwidth'
  depends_on 'ncurses' # R

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

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
