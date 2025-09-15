require 'buildsystems/meson'

class Desktop_file_utils < Meson
  description 'contains a few command line utilities for working with desktop entries'
  homepage 'https://www.freedesktop.org/wiki/Software/desktop-file-utils/'
  version '0.28'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-#{version}.tar.xz"
  source_sha256 '4401d4e231d842c2de8242395a74a395ca468cd96f5f610d822df33594898a70'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b13f9202b0b0f3d36a7fc0df45a7f321eebf1efc870aa553b2e8c435bfa1a063',
     armv7l: 'b13f9202b0b0f3d36a7fc0df45a7f321eebf1efc870aa553b2e8c435bfa1a063',
       i686: 'af80702f193a3ec436b122b9f20889b196d51eac01c7c2c5b6e432e466a2c303',
     x86_64: '3f2a161ca73edca9d51619b39bd27acd23eb6259947f41a2d2bfda3a2720695c'
  })
end
