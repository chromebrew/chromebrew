require 'buildsystems/autotools'

class Gzip < Autotools
  description 'GNU Gzip is a popular data compression program originally written by Jean-loup Gailly for the GNU project.'
  homepage 'https://www.gnu.org/software/gzip/'
  version '1.13'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://ftpmirror.gnu.org/gzip/gzip-1.13.tar.xz'
  source_sha256 '7454eb6935db17c6655576c2e1b0fabefd38b4d0936e0f87f48cd062ce91a057'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.13_armv7l/gzip-1.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.13_armv7l/gzip-1.13-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.13_x86_64/gzip-1.13-chromeos-x86_64.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gzip/1.13_i686/gzip-1.13-chromeos-i686.tar.zst'
  })
  binary_sha256({
    aarch64: '787cab0140058f4c0ce09a56b95df269540b39738fcb8483351d1586b00a840f',
     armv7l: '787cab0140058f4c0ce09a56b95df269540b39738fcb8483351d1586b00a840f',
     x86_64: 'c2e8d1af7bcb50c90a0aa5168d4af9b9cfb7286e904d0e0da807eb3b95d02e54',
       i686: '87cdfa0d7f9719e17ca2e90578fab3326c0ab5f5fd55ee8ba9181db38bd37243'
  })

  run_tests
end
