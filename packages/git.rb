require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.33.1'
  version "#{@_ver}-musl"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 'fa459f95153a2c51af149c062f614018c027caf75a8dd92b3f64defe0a78f42f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.33.0-musl_armv7l/git-2.33.0-musl-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.33.0-musl_armv7l/git-2.33.0-musl-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.33.0-musl_i686/git-2.33.0-musl-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.33.0-musl_x86_64/git-2.33.0-musl-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '494c215c9b20bba8fe9eba3fec2751056a40cae28ff7727d8e8edbed8d6d9e00',
     armv7l: '494c215c9b20bba8fe9eba3fec2751056a40cae28ff7727d8e8edbed8d6d9e00',
       i686: '0fa7cdd252d0af0c27b03e11024f292aa4733f6d4493017e67ae4e6361a7a63f',
     x86_64: '1a736a5c346dfc5438fc776debbd05f8a73c83825f2ef8f220eef8d45386a7f5'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'curl' => :build
  depends_on 'rust' => :build
  depends_on 'musl_brotli' => :build
  depends_on 'musl_c_ares' => :build
  depends_on 'musl_cyrus_sasl' => :build
  depends_on 'musl_expat' => :build
  depends_on 'musl_krb5' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_libnghttp2' => :build
  depends_on 'musl_libssh' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_zstd' => :build

  def self.patch
    # Patch to prevent error function conflict with libidn2
    # By replacing all calls to error with git_error.
    system "sed -i 's,^#undef error\$,#undef git_error,' usage.c"
    sedcmd = 's/\([[:blank:]]\)error(/\1git_error(/'.dump
    system "grep -rl '[[:space:]]error(' . | xargs sed -i #{sedcmd}"
    sedcmd2 = 's/\([[:blank:]]\)error (/\1git_error (/'.dump
    system "grep -rl '[[:space:]]error (' . | xargs sed -i #{sedcmd2}"
    system "grep -rl ' !!error(' . | xargs sed -i 's/ \!\!error(/ \!\!git_error(/g'"
    system "sed -i 's/#define git_error(...) (error(__VA_ARGS__), const_error())/#define git_error(...) (git_error(__VA_ARGS__), const_error())/' git-compat-util.h"
  end

  def self.build
    @abi = ''
    @arch_ssp_cflags = ''
    @arch_c_flags = ''
    @arch_cxx_flags = ''
    case ARCH
    when 'aarch64', 'armv7l'
      @abi = 'eabihf'
    when 'i686'
      @arch_ssp_cflags = '-fno-stack-protector'
    when 'x86_64'
    end

    @cflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} #{@arch_ssp_cflags} -fcommon"
    @cxxflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} #{@arch_ssp_cflags} -fcommon"
    @ldflags = "-L#{CREW_PREFIX}/musl/lib -flto -static"
    @cmake_ldflags = '-flto'
    @musldep_cmake_options = "PATH=#{CREW_PREFIX}/musl/bin:#{CREW_PREFIX}/musl/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        AR=#{CREW_PREFIX}/musl/bin/ar \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
        LDFLAGS='#{@cmake_ldflags}' \
        cmake \
        -DCMAKE_INSTALL_PREFIX='#{CREW_PREFIX}/musl' \
        -DCMAKE_INSTALL_LIBDIR='#{CREW_PREFIX}/musl/lib' \
        -DCMAKE_LIBRARY_PATH='#{CREW_PREFIX}/musl/lib' \
        -DCMAKE_C_COMPILER=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc \
        -DCMAKE_CXX_COMPILER=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++ \
        -DCMAKE_INCLUDE_DIRECTORIES_BEFORE=ON \
        -DINCLUDE_DIRECTORIES=#{CREW_PREFIX}/musl/include \
        -DCMAKE_C_FLAGS='#{@cflags}' \
        -DCMAKE_CXX_FLAGS='#{@cxxflags}' \
        -DCMAKE_EXE_LINKER_FLAGS='#{@cmake_ldflags}' \
        -DCMAKE_SHARED_LINKER_FLAGS='#{@cmake_ldflags}' \
        -DCMAKE_STATIC_LINKER_FLAGS='#{@cmake_ldflags}' \
        -DCMAKE_MODULE_LINKER_FLAGS='#{@cmake_ldflags}' \
        -DPROPERTY_INTERPROCEDURAL_OPTIMIZATION=TRUE \
        -DCMAKE_BUILD_TYPE=Release"

    @krb5_static_libs = "#{CREW_PREFIX}/musl/lib/libkrb5support.a  #{CREW_PREFIX}/musl/lib/libgssapi_krb5.a #{CREW_PREFIX}/musl/lib/libkrb5.a  #{CREW_PREFIX}/musl/lib/libk5crypto.a #{CREW_PREFIX}/musl/lib/libcom_err.a"

    # This build is dependent upon the musl curl package
    @curl_static_libs = `#{CREW_PREFIX}/musl/bin/curl-config --static-libs`.chomp.gsub('=auto', '')
    @git_libs = "#{@curl_static_libs} #{@krb5_static_libs} \
        -l:libresolv.a \
        -l:libm.a \
        -l:libbrotlidec-static.a \
        -l:libbrotlicommon-static.a \
        -l:libzstd.a \
        -l:libssl.a \
        -l:libcrypto.a \
        -l:libz.a \
        -l:libsasl2.a \
        -l:libnghttp2.a \
        -l:libpthread.a \
        -l:libncursesw.a \
        -l:libtinfow.a \
        -l:libcurl.a \
        -l:libcares.a \
        -l:libidn2.a \
        -l:libssh.a"
    @git_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        LIBS='#{@git_libs}' \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{CREW_PREFIX}/musl/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB -fcommon' \
        LDFLAGS='#{@ldflags} \
       #{@git_libs}'"

    system 'autoreconf -fiv'
    system "#{@git_env_options} \
    ./configure \
      --prefix=#{CREW_PREFIX}/musl \
      --libdir=#{CREW_PREFIX}/musl/lib \
      CURL_LDFLAGS='-L#{CREW_PREFIX}/musl/lib #{@git_libs}' \
      --with-openssl \
      --without-tcltk \
      --with-curl \
      --with-perl=#{CREW_PREFIX}/bin/perl \
      --with-python=#{CREW_PREFIX}/bin/python3 \
      --with-gitconfig=#{CREW_PREFIX}/etc/gitconfig \
      --with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    system 'cp config.log /tmp'
    system "#{@git_env_options} make -j#{CREW_NPROC}"
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @git_bashd_env = <<~GIT_BASHD_EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    GIT_BASHD_EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/git", @git_bashd_env)
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_DEST_PREFIX}/musl/bin/git", "#{CREW_DEST_PREFIX}/bin/git"
  end

  def self.check
    # Check to see if linking libcurl worked, which means
    # git-remote-https should exist
    system "ls #{CREW_DEST_PREFIX}/musl/libexec/git-core/git-remote-https || exit 1"
  end
end
