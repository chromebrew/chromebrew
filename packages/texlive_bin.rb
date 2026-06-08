require 'buildsystems/autotools'

class Texlive_bin < Autotools
  description 'All the binaries of TeX Live packages..'
  homepage 'https://github.com/TeX-Live/texlive-source'
  version '78399'
  license 'GPL-2 and GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/TeX-Live/texlive-source.git'
  git_hashtag "svn#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4cce4364076946c551582b29788b747681d5c1826973dbbba97df3d03254530',
     armv7l: 'c4cce4364076946c551582b29788b747681d5c1826973dbbba97df3d03254530',
     x86_64: '7b295f7769a64a85a8c8f1bcfe3330181ab43263f8501692926c94db793ba67e'
  })

  depends_on 'cairo' => :executable
  depends_on 'fontconfig' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'ghostscript' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :executable
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'graphite' => :executable
  depends_on 'harfbuzz' => :executable
  depends_on 'icu4c' => :executable
  depends_on 'libbsd' => :executable
  depends_on 'libgd' => :build
  depends_on 'libice' => :executable
  depends_on 'libpaper' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libsm' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxau' => :executable
  depends_on 'libxaw' => :executable
  depends_on 'libxcb' => :executable
  depends_on 'libxdmcp' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxi' => :executable
  depends_on 'libxmu' => :executable
  depends_on 'libxpm' => :executable
  depends_on 'libxt' => :executable
  depends_on 'mpfi' => :executable
  depends_on 'mpfr' => :executable
  depends_on 'pixman' => :executable
  depends_on 'potrace' => :executable
  depends_on 'util_linux' => :executable
  depends_on 'zlib' => :library

  prerelease

  autotools_pre_configure_options "CXXFLAGS+=' -std=c++17 '"
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
  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
