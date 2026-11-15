require 'buildsystems/autotools'

class Autoconf_archive < Autotools
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2026.11.11'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/autoconf-archive/autoconf-archive-#{version}.tar.xz"
  source_sha256 '2c18f15e2b3bb79e09622b27391df07d8608ce9f07fbfc7c1143fa683891ab26'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67c8051d83c45f8befaee84f084458a9ab8f2bba0c8474a9bf3f04137a7bc510',
     armv7l: '67c8051d83c45f8befaee84f084458a9ab8f2bba0c8474a9bf3f04137a7bc510',
       i686: 'e8194e7531dde09786917b7cdcc793298f0b58f86f59b5bae33181a16866700c',
     x86_64: '6ed5d2ba429df3b5c83039612ff923e377b07ad988557924222734bbe6601e0f'
  })
end
