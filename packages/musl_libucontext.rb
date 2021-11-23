require 'package'

class Musl_libucontext < Package
  description 'Library which provides the ucontext.h C API'
  homepage 'https://github.com/kaniini/libucontext'
  @_ver = '1.1'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/kaniini/libucontext.git'
  git_hashtag "libucontext-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libucontext/1.1_armv7l/musl_libucontext-1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libucontext/1.1_armv7l/musl_libucontext-1.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libucontext/1.1_i686/musl_libucontext-1.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libucontext/1.1_x86_64/musl_libucontext-1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ecb4f59b8669ea34f61cb5889e46f5de6be4241f8730c570d2f180d30782370f',
     armv7l: 'ecb4f59b8669ea34f61cb5889e46f5de6be4241f8730c570d2f180d30782370f',
       i686: '6bc511905bc917b2cd3ecf708760e18fd3b2c1f59560b1f5796bdeb2e3c4ffaf',
     x86_64: 'cc3d984411b2353fe19cb3796cbe0d8a590b48d7e7998dc6a42d22703201c325'
  })

  depends_on 'musl_native_toolchain' => :build

  @abi = ''
  @arch_c_flags = ''
  @arch_cxx_flags = ''
  case ARCH
  when 'aarch64', 'armv7l'
    @abi = 'eabihf'
    @arch = 'arm'
  when 'i686'
    @arch = 'X86'
  when 'x86_64'
    @arch = 'X86_64'
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
      LIBDIR=#{CREW_PREFIX}/musl/lib \
      INCLUDEDIR=#{CREW_PREFIX}/musl/include \
      PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      PKGCONFIGDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      CFLAGS='#{@cflags}' \
      CXXFLAGS='#{@cxxflags}' \
      CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
      LDFLAGS='#{@ldflags}'"

  def self.patch
    system "sed -i 's,LIBDIR := /lib,LIBDIR := #{CREW_PREFIX}/musl/lib,g' Makefile"
    system "sed -i 's,INCLUDEDIR := /usr/include,INCLUDEDIR := #{CREW_PREFIX}/musl/include,g' Makefile"
    system "sed -i 's,PKGCONFIGDIR := /usr/lib/pkgconfig,PKGCONFIGDIR := #{CREW_PREFIX}/musl/lib/pkgconfig,g' Makefile"
  end

  def self.build
    system "#{@musldep_env_options} make ARCH=#{@arch}"
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system "make ARCH=#{@arch} DESTDIR=#{CREW_DEST_DIR} install"
  end
end
