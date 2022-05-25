require 'package'

class Sassc < Package
  description 'C implementation of Sass CSS preprocessor.'
  homepage 'https://github.com/sass/sassc'
  version '3.6.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/sass/sassc.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sassc/3.6.2_armv7l/sassc-3.6.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sassc/3.6.2_armv7l/sassc-3.6.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sassc/3.6.2_i686/sassc-3.6.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/sassc/3.6.2_x86_64/sassc-3.6.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b34876c122bce81fb000e249e3c240781e0815c5139255a5d92e45184959b80d',
     armv7l: 'b34876c122bce81fb000e249e3c240781e0815c5139255a5d92e45184959b80d',
       i686: '17acfe27361d4e8e2258fd5be8960ee24b7fcf2ae9e854ff4ab4d7ceb1373bed',
     x86_64: '1d2cc3adbb8fdab70a69cc32975f10ca8c382fe04402d9717889787bcc580ffb'
  })

  depends_on 'libsass'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -i'
    system "./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
