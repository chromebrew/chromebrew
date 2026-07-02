# Adapted from Arch Linux colm PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=colm

require 'buildsystems/autotools'

class Colm < Autotools
  description 'Programming language designed for analysis and transformation of computer languages'
  homepage 'https://www.colm.net/open-source/colm/'
  version '0.12.0'
  license 'GPL'
  compatibility 'all'
  source_url "https://www.colm.net/files/colm/colm-#{version}.tar.gz"
  source_sha256 '7b545d74bd139f5c622975d243c575310af1e4985059a1427b6fdbb1fb8d6e4d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8edc2dfccadae1b99c06e7973bd17e6ac01f6fabd438d765751cbc964bd5f121',
     armv7l: '8edc2dfccadae1b99c06e7973bd17e6ac01f6fabd438d765751cbc964bd5f121',
       i686: 'a3f0f6bacf4b58504c3a2e90d22f4020d0d81bbc169448f2292385efa7cbb400',
     x86_64: 'ae7866fc233f5ec1706b9daaa954f833139d852b2cee8db1438ee3e5a76ca008'
  })
end
