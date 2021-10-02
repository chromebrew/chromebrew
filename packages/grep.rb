# Adapted from Arch Linux grep PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/grep/trunk/PKGBUILD

require 'package'

class Grep < Package
  description 'A string search utility'
  homepage 'https://www.gnu.org/software/grep/'
  version '3.7'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/grep/grep-3.7.tar.xz'
  source_sha256 '5c10da312460aec721984d5d83246d24520ec438dd48d7ab5a05dbc0d6d6823c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.7_armv7l/grep-3.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.7_armv7l/grep-3.7-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.7_i686/grep-3.7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/grep/3.7_x86_64/grep-3.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '86fca9359de8d9ccf234f43091a7518ca00fa6668f26fb9ce1cf1bbae3f50026',
     armv7l: '86fca9359de8d9ccf234f43091a7518ca00fa6668f26fb9ce1cf1bbae3f50026',
       i686: '1c9a1c6d8dbb4881f72342f6c1d96b2b55f9054b5f57372e61cdd7f4cd99c4b0',
     x86_64: '958e21200e2be34683b3a31b8cadd9a3a37afaeb9bf0ab932befb50cf654fded'
  })

  depends_on 'pcre'

  def self.build
    system "#{CREW_ENV_OPTIONS} \
      CPPFLAGS=-DHAVE_DYNAMIC_LIBPCRE \
      ./configure #{CREW_OPTIONS} \
      --without-included-regex"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
