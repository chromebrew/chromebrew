require 'buildsystems/autotools'

class Texlive_bin < Autotools
  description 'All the binaries of TeX Live packages..'
  homepage 'https://github.com/TeX-Live/texlive-source'
  version 'svn78399'
  license 'GPL-2 and GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/TeX-Live/texlive-source.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6917ab894942b7f93d9874eec5a517308f919a4ee921d96c9219652ba0bfd841',
     armv7l: '6917ab894942b7f93d9874eec5a517308f919a4ee921d96c9219652ba0bfd841',
     x86_64: '0e83582364c12a63c9f20c0d8259fe62db28fac2c4ef9a3e164b8c80d65fdc0d'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'cairo' => :build
  depends_on 'freetype' => :build
  depends_on 'ghostscript' => :build
  depends_on 'graphite' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'libgd' => :build
  depends_on 'libice' => :build
  depends_on 'libpaper' => :build
  depends_on 'libpng' => :build
  depends_on 'libsm' => :build
  depends_on 'libx11' => :build
  depends_on 'libxaw' => :build
  depends_on 'libxext' => :build
  depends_on 'libxi' => :build
  depends_on 'libxmu' => :build
  depends_on 'libxpm' => :build
  depends_on 'libxt' => :build
  depends_on 'mpfi' => :build
  depends_on 'mpfr' => :build
  depends_on 'pixman' => :build
  depends_on 'potrace' => :build
  depends_on 'zlib' => :build

  autotools_configure_options "--enable-build-in-source-tree \
                              --datarootdir=#{CREW_PREFIX}/share/texlive \
                              --disable-native-texlive-build \
                              --disable-missing \
                              --disable-linked-scripts \
                              --with-banner-add=/Chromebrew \
                              --enable-shared \
                              --with-system-zlib \
                              --with-system-potrace \
                              --with-system-graphite2 \
                              --with-system-harfbuzz \
                              --with-system-libgs \
                              --with-system-pixman \
                              --with-system-libpaper \
                              --with-system-icu \
                              --with-system-gmp \
                              --with-system-mpfi \
                              --with-system-mpfr \
                              --with-system-freetype2 \
                              --with-freetype2-include=#{CREW_PREFIX}/include/freetype2 \
                              --with-system-libpng \
                              --with-system-gd \
                              --with-system-cairo  \
                              --with-x \
                              --with-mf-x-toolkit \
                              --with-xdvi-x-toolkit=xaw \
                              --disable-lcdf-typetools \
                              --disable-biber	 \
                              --disable-dvipng \
                              --disable-ps2eps \
                              --disable-psutils \
                              --disable-t1utils \
                              --disable-cjkutils \
                              --disable-chktex \
                              --disable-lacheck \
                              --disable-texdoctk \
                              --disable-ttf2pk \
                              --disable-dvisvgm \
                              --enable-ttf2pk2 \
                              --enable-ipc"
end
