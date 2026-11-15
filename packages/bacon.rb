require 'buildsystems/autotools'

class Bacon < Autotools
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'https://chiselapp.com/user/bacon/repository/bacon/home'
  version '5.0.4'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.basic-converter.org/stable/bacon-#{version}.tar.gz"
  source_sha256 'bc771cb23efa589dd13abbc599564b9667392e0060db3cc4bda205eebaf72ab0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9419f1eac5f375c0848e7079f6ccff92ba43cc318a5893b31331f61744864bc2',
     armv7l: '9419f1eac5f375c0848e7079f6ccff92ba43cc318a5893b31331f61744864bc2',
       i686: '302224d70289867631e116cced2681a0da1f3a320c2b91a38debd7085d6c0d29',
     x86_64: '307bae5ab40b2d5072888554f0bdfc469ec16ef5f688efa4c92ba687d960946e'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  def self.patch
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
  end

  autotools_configure_options '--disable-gui'
end
