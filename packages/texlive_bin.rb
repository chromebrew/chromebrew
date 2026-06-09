require 'buildsystems/autotools'

class Texlive_bin < Autotools
  description 'All the binaries of TeX Live packages.'
  homepage 'https://github.com/TeX-Live/texlive-source'
  version '78399-1'
  license 'GPL-2 and GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/TeX-Live/texlive-source.git'
  git_hashtag "svn#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1e2981db88b9f67734c9038499a086aab86a7b2c254867caf84327c4cee202af',
     armv7l: '1e2981db88b9f67734c9038499a086aab86a7b2c254867caf84327c4cee202af',
     x86_64: '1a6ccb05840bf2838c38e7bbecbf11e9c9479601bc732056f9103448d74c1c83'
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
  depends_on 'libgd' => :executable
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
  # dvisvgm throws this error:
  # PSInterpreter.cpp: In destructor ‘virtual PSInterpreter::~PSInterpreter()’:
  # PSInterpreter.cpp:47:13: error: ‘struct Ghostscript’ has no member named ‘finalize’
  #    47 |         _gs.finalize();
  #       |             ^~~~~~~~

  # with-system-zziplib throws this erroe:
  # mold: error: undefined symbol: zzip_open_ext_io64
  autotools_configure_options "--enable-build-in-source-tree \
                              --datarootdir=#{CREW_PREFIX}/share/texlive \
                              --disable-native-texlive-build \
                              --with-banner-add=/Chromebrew \
                              --disable-dvisvgm \
                              --enable-aleph \
                              --enable-ipc \
                              --enable-luajithbtex \
                              --enable-luajittex \
                              --enable-mfluajit \
                              --enable-shared \
                              --enable-ttf2pk2 \
                              --with-freetype2-include=#{CREW_PREFIX}/include/freetype2 \
                              --with-mf-x-toolkit \
                              --with-system-cairo  \
                              --with-system-freetype2 \
                              --with-system-gd \
                              --with-system-gmp \
                              --with-system-graphite2 \
                              --with-system-harfbuzz \
                              --with-system-icu \
                              --with-system-libgs \
                              --with-system-libpaper \
                              --with-system-libpng \
                              --with-system-mpfi \
                              --with-system-mpfr \
                              --with-system-pixman \
                              --with-system-potrace \
                              --with-system-zlib \
                              --with-x \
                              --with-xdvi-x-toolkit=xaw"

  autotools_install_extras do
    # As per https://gitlab.alpinelinux.org/alpine/aports/-/commit/89e20594b80546e18ed096139c9a8d7f0218dec2?file_path=community%2Ftexlive%2FAPKBUILD#6dea62465568b876d1480a3ed79c182793c87872
    system "PATH=#{CREW_DEST_PREFIX}/bin:\$PATH #{CREW_DEST_PREFIX}/bin/texlinks -f #{CREW_DEST_PREFIX}/share/texlive/texmf-dist/web2c/fmtutil.cnf #{CREW_DEST_PREFIX}/bin"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/tlmgr"
  end

  def self.prebuild
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end
end
