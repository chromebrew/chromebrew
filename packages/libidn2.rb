require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.3.1-1'
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libidn/libidn2-2.3.1.tar.gz'
  source_sha256 '8af684943836b8b53965d5f5b6714ef13c26c91eaa36ce7d242e3d21f5d40f2d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1-1_armv7l/libidn2-2.3.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1-1_armv7l/libidn2-2.3.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1-1_i686/libidn2-2.3.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1-1_x86_64/libidn2-2.3.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b9c6d94688c48b1eae57d2c62e41c15bb4c7942eae4683bc39699f09865d0ad7',
     armv7l: 'b9c6d94688c48b1eae57d2c62e41c15bb4c7942eae4683bc39699f09865d0ad7',
       i686: '985b7de2215322d8b7becb9a7673e26d70db39e497b9a2d3af1f6304f6bb2d15',
     x86_64: '4fd2287da572b21f87a2d63c5c6c933169fa69735075447d8aa83c244a236c37'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
