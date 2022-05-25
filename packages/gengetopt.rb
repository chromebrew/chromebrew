require 'buildsystems/autotools'

class Gengetopt < Autotools
  description 'This program generates a C function that uses getopt_long function to parse the command line options, to validate them and fills a struct .'
  homepage 'https://www.gnu.org/software/gengetopt/'
  version '2.23'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gengetopt/gengetopt-2.23.tar.xz'
  source_sha256 'b941aec9011864978dd7fdeb052b1943535824169d2aa2b0e7eae9ab807584ac'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.23_armv7l/gengetopt-2.23-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.23_armv7l/gengetopt-2.23-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.23_i686/gengetopt-2.23-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.23_x86_64/gengetopt-2.23-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ad134cbf8d8cbc36a589dce0013b9f952d122700df4bab2c3cd40bc17d2a7a01',
     armv7l: 'ad134cbf8d8cbc36a589dce0013b9f952d122700df4bab2c3cd40bc17d2a7a01',
       i686: 'a0f64b05cbdc817d908e19031930c9624abcbd04b8865f144b3d448ed6573ac7',
     x86_64: '002712609debd70bb81c76809c627914bcf7f4467f0bfdcfb5052b9f7fd19c50'
  })
end
