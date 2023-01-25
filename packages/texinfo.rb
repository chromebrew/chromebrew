require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '7.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/texinfo/texinfo-7.0.tar.xz'
  source_sha256 '20744b82531ce7a04d8cee34b07143ad59777612c3695d5855f29fba40fbe3e0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0_armv7l/texinfo-7.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0_armv7l/texinfo-7.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0_i686/texinfo-7.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/texinfo/7.0_x86_64/texinfo-7.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b2a728d4411d0f6413b4799db055b2a86d34de21b4a3fab0b63816a75e5a1c0f',
     armv7l: 'b2a728d4411d0f6413b4799db055b2a86d34de21b4a3fab0b63816a75e5a1c0f',
       i686: '5d2bc0b29e4066dfb002a618089cefe8c438635e45e9cce523fd3da6691c18a8',
     x86_64: '2c5c0166ad926b0fbafed07ae06b44635bba753fdc569108d6f07dbfb314a7ed'
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

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
