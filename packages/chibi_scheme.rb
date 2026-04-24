require 'buildsystems/autotools'

class Chibi_scheme < Autotools
  description 'Minimal Scheme Implementation for use as an Extension Language'
  homepage 'http://synthcode.com/wiki/chibi-scheme'
  version '0.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/ashinn/chibi-scheme.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '999eb071a1976e226059ff57f6ed896eaa948841ddde03752c14a16072887f57',
     armv7l: '999eb071a1976e226059ff57f6ed896eaa948841ddde03752c14a16072887f57',
       i686: 'c5b62881ed97ba9e65ea740e5a48ecb1f42f7f5a5323cf0a3b512327070918e0',
     x86_64: '00a33135bdf465723eb4854a835080b1b06dd2403c141874be8733c5fb4ed416'
  })

  depends_on 'glibc' => :library

  def self.patch
    system 'sed -i -e \'/LDCONFIG/d\' Makefile'
    system 'sed -i \'/^IMAGE_FILES =/c\IMAGE_FILES =\' Makefile' # wasn't able to override via CLI
  end

  autotools_pre_make_options "PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} SOLIBDIR=#{CREW_LIB_PREFIX}"
  autotools_install_options "PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} SOLIBDIR=#{CREW_LIB_PREFIX}"
end
