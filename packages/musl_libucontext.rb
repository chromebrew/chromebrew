require 'package'

class Musl_libucontext < Package
  description 'Library which provides the ucontext.h C API'
  homepage 'https://github.com/kaniini/libucontext'
  @_ver = '1.1'
  version @_ver
  compatibility 'all'
  source_url 'https://github.com/kaniini/libucontext.git'
  git_hashtag "libucontext-#{@_ver}"

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
    #system "./configure --prefix=#{CREW_PREFIX}/musl \
      ##{@musldep_env_options} \
      #--enable-shared \
      #--enable-static"
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
