# Adapted from Arch Linux libsmi PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libsmi

require 'buildsystems/autotools'

class Libsmi < Autotools
  description 'C library allowing NM apps and MIB and PIB authoring tools to access SMI MIB info. '
  homepage 'http://www.ibr.cs.tu-bs.de/projects/libsmi/'
  version '0.5.0'
  license 'Custom'
  compatibility 'all'
  source_url 'https://www.ibr.cs.tu-bs.de/projects/libsmi/download/libsmi-0.5.0.tar.gz'
  source_sha256 'f21accdadb1bb328ea3f8a13fc34d715baac6e2db66065898346322c725754d3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3fb011d0ed0dc82f35d80637f352674edd3a7ba0c47be764a251f5bf3c05be87',
     armv7l: '3fb011d0ed0dc82f35d80637f352674edd3a7ba0c47be764a251f5bf3c05be87',
       i686: '9efb102effa9e2f63a2c02de2ed4ac8789f2cefa8eaa4b041f0f5ce6d2ce30ed',
     x86_64: 'fadcd2e4e231f770556422d6d31b60875bafcc6ccd604f7e84c386a4a6fcf123'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
