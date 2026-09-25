require 'buildsystems/autotools'

class Lzo < Autotools
  description 'LZO is a portable lossless data compression library written in ANSI C.'
  homepage 'http://www.oberhumer.com/opensource/lzo/'
  version '2.10'
  license 'GPL-2+'
  compatibility 'all'
  source_url "https://www.oberhumer.com/opensource/lzo/download/lzo-#{version}.tar.gz"
  source_sha256 'c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bdbc8f70380449f6e6c88b2757b0e74d0fc85dcdc18f11b25ae6e121351fed0f',
     armv7l: 'bdbc8f70380449f6e6c88b2757b0e74d0fc85dcdc18f11b25ae6e121351fed0f',
       i686: '8b4d18a37e159d1577651c39b34f0117e9c376524e0858349daf5d9c0d582ab0',
     x86_64: '7273e03053685652fe8af5fe5abced0b584e694ffc5e511a1516acfe5cfb97c7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options ' \
    --enable-shared \
    --disable-static'
end
