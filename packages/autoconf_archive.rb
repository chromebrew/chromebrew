require 'buildsystems/autotools'

class Autoconf_archive < Autotools
  description 'GNU Autoconf Archive is a collection of freely re-usable Autoconf macros.'
  homepage 'https://www.gnu.org/software/autoconf-archive/'
  version '2024.10.16'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-#{version}.tar.xz"
  source_sha256 'e07454f00d8cae7907bed42d0747798927809947684d94c37207a4d63a32f423'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e08a3bf59c5973ec5fee59d4692fd266d8082c753fca0f8dcc27448da44ba8a',
     armv7l: '3e08a3bf59c5973ec5fee59d4692fd266d8082c753fca0f8dcc27448da44ba8a',
       i686: '8a69c686eb94611f432847d68b8d8fa3787548d002072266e9807635c878c30b',
     x86_64: 'dc9e54c5af6fb9271d4c5599f50f2d98f311f3550ad326b45f48eb7484255a29'
  })
end
