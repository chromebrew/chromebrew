# Adapted from Arch Linux libbacktrace-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libbacktrace-git

require 'package'

class Musl_libbacktrace < Package
  description 'Library to produce symbolic backtraces'
  homepage 'https://github.com/ianlancetaylor/libbacktrace'
  version 'd0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a'
  compatibility 'all'
  source_url 'https://github.com/ianlancetaylor/libbacktrace.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_armv7l/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_armv7l/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_i686/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libbacktrace/d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a_x86_64/musl_libbacktrace-d0f5e95a87a4d3e0a1ed6c069b5dae7cbab3ed2a-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '19bc88daa2ee3de04167a159d2a52d1f35e3f54e531847de9b441517cfef7d4b',
     armv7l: '19bc88daa2ee3de04167a159d2a52d1f35e3f54e531847de9b441517cfef7d4b',
       i686: '1dc24f90bd5cb0c86518f6843906fa28647f8e3c4c4c44ce33e41707e22cf967',
     x86_64: '24b85b73f26b55343485cca8938aebfcd09c586ffba6cef5a7430b4a0336c82b'
  })

  depends_on 'musl_native_toolchain' => :build

  @abi = ''
  @arch_c_flags = ''
  @arch_cxx_flags = ''
  case ARCH
  when 'aarch64', 'armv7l'
    @abi = 'eabihf'
  end

  @cflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} -fcommon"
  @cxxflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} -fcommon -static"
  @ldflags = "-L#{CREW_PREFIX}/musl/lib -flto -static"
  @cmake_ldflags = '-flto'

  @musldep_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
      LIBRARY_PATH='#{CREW_PREFIX}/musl/lib:$LIBRARY_PATH' \
      CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
      CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
      LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
      PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      CFLAGS='#{@cflags}' \
      CXXFLAGS='#{@cxxflags}' \
      CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
      LDFLAGS='#{@ldflags}'"

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}/musl \
      #{@musldep_env_options} \
      --enable-shared \
      --enable-static"
    system 'make'
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
