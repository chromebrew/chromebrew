require 'buildsystems/autotools'

class Gzip < Autotools
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.14'
  compatibility 'all'
  license 'GPL-3'
  source_url "https://ftpmirror.gnu.org/gzip/gzip-#{version}.tar.xz"
  source_sha256 '7454eb6935db17c6655576c2e1b0fabefd38b4d0936e0f87f48cd062ce91a057'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '787cab0140058f4c0ce09a56b95df269540b39738fcb8483351d1586b00a840f',
     armv7l: '787cab0140058f4c0ce09a56b95df269540b39738fcb8483351d1586b00a840f',
       i686: 'f3b6c28a23474b435d3b9479af4f003e50a873bd599b8ec5cba2b1e582b90936',
     x86_64: 'c2e8d1af7bcb50c90a0aa5168d4af9b9cfb7286e904d0e0da807eb3b95d02e54'
  })

  depends_on 'glibc' # R

  run_tests
end
