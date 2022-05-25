require 'package'

class Autoconf_archive < Package
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2022.09.13'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2022.09.03.tar.xz'
  source_sha256 'e07454f00d8cae7907bed42d0747798927809947684d94c37207a4d63a32f423'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf_archive/2022.09.13_armv7l/autoconf_archive-2022.09.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf_archive/2022.09.13_armv7l/autoconf_archive-2022.09.13-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf_archive/2022.09.13_i686/autoconf_archive-2022.09.13-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/autoconf_archive/2022.09.13_x86_64/autoconf_archive-2022.09.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '20358b2576af31e463bcfbaa6f99470729cf1eb483531079b9e534c691648594',
     armv7l: '20358b2576af31e463bcfbaa6f99470729cf1eb483531079b9e534c691648594',
       i686: 'a9daa783895ede3d7b2b3fcbc75fd35257414eb612477fbac6389502138fba7b',
     x86_64: '812f12231da8f71a5bf358cd70564975e6709e54fbcd06d6a9c58cb6d662aec8'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
