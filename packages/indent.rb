require 'buildsystems/autotools'

class Indent < Autotools
  description 'The indent program can be used to make C language code easier to read.'
  homepage 'https://www.gnu.org/software/indent/'
  version '2.2.13'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/indent/indent-#{version}.tar.xz"
  source_sha256 '87ff9d801cb11969181d5b8cf8b65e65e5b24bb0c76a1b825e8098f2906fbdf4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7b1150e2b697451f23a882709d3b7592834d93fbd1f7cccf98f5a0b6d4ecf465',
     armv7l: '7b1150e2b697451f23a882709d3b7592834d93fbd1f7cccf98f5a0b6d4ecf465',
       i686: '8d9ad2085432d978bbf7377ddd904a3ab6d2e86db58fc86ef101bbf8f5138b50',
     x86_64: '3bde20cd3215760975bdf8016c53cbc279fe19b8a270b4f204b5d91270941c9b'
  })

  depends_on 'glibc' # R

  run_tests
end
