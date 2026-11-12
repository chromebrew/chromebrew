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
    aarch64: '3e08a3bf59c5973ec5fee59d4692fd266d8082c753fca0f8dcc27448da44ba8a',
     armv7l: '3e08a3bf59c5973ec5fee59d4692fd266d8082c753fca0f8dcc27448da44ba8a',
       i686: '8a69c686eb94611f432847d68b8d8fa3787548d002072266e9807635c878c30b',
     x86_64: 'dc9e54c5af6fb9271d4c5599f50f2d98f311f3550ad326b45f48eb7484255a29'
  })
end
