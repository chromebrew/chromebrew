require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.31.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 'b1c0e95e9861b5d1b9ad3d8deaa2d8c7f02304ffc1b5e8869dd9fb98f9a0d436'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-1_armv7l/git-2.31.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-1_armv7l/git-2.31.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-1_i686/git-2.31.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-1_x86_64/git-2.31.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '364b30aafa845d7950b93fd67e72fcc752008dee08ff571155ffb4239eaba2ac',
     armv7l: '364b30aafa845d7950b93fd67e72fcc752008dee08ff571155ffb4239eaba2ac',
       i686: 'b80054bb43df65051d37c0c8e7f83c46f97d084027d7997871be91a7731a642c',
     x86_64: 'c0bf7de6181f29f73abc75793410441aabcf2b71c3bd7a4321179a59859a47e6'
  })

  def self.build
    abort('Please remove libiconv before building.') if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    @curl_static_libs = `curl-config --static-libs`.chomp.gsub('=auto', '')
    @sasl2_static_libs = "#{CREW_LIB_PREFIX}/libdb.a #{CREW_LIB_PREFIX}/libsasl2.a " + `pkg-config --libs --static libsasl2`.chomp
    @krb5_static_libs = "#{CREW_LIB_PREFIX}/libkrb5support.a #{CREW_LIB_PREFIX}/libgssapi_krb5.a #{CREW_LIB_PREFIX}/libkrb5.a #{CREW_LIB_PREFIX}/libk5crypto.a #{CREW_LIB_PREFIX}/libcom_err.a"
    @ldflags = "-flto -static -L#{CREW_LIB_PREFIX} #{@krb5_static_libs} #{@sasl2_static_libs} -lgmp #{@curl_static_libs} -lunistring -Wl,--no-as-needed -ldl"

    FileUtils.mkdir 'curl'
    FileUtils.ln_s "#{CREW_PREFIX}/include/curl", 'curl/include'
    FileUtils.ln_s CREW_LIB_PREFIX, "curl/lib#{CREW_LIB_SUFFIX}"
    system 'autoreconf -fiv'
    # Build with clang to get truly static binaries.
    system "./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      --mandir=#{CREW_MAN_PREFIX} \
      CC=clang CXX=clang++ LD='ld.lld -L#{CREW_LIB_PREFIX} -lcurl'  CFLAGS='-flto -pipe -O3 -static -fuse-ld=lld' \
      CXXFLAGS='-flto -pipe -O3 -static -fuse-ld=lld' \
      LDFLAGS='#{@ldflags}' \
      CURL_CONFIG=#{CREW_PREFIX}/bin/curl-config \
      CURLDIR=`pwd`/curl \
      CURL_LDFLAGS='-L#{CREW_LIB_PREFIX} #{@curl_static_libs}' \
      AR=llvm-ar \
      --with-lib='lib#{CREW_LIB_SUFFIX}' \
      --with-openssl \
      --without-tcltk \
      --with-curl \
      --with-perl=#{CREW_PREFIX}/bin/perl \
      --with-python=#{CREW_PREFIX}/bin/python3 \
      --with-gitconfig=#{CREW_PREFIX}/etc/gitconfig \
      --with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    # Make seems to need environment variables passed again here.
    system "make CC='clang -L#{CREW_LIB_PREFIX} -lcurl' CXX=clang++ LD=ld.lld  CFLAGS='-flto -pipe -O3 -static -fuse-ld=lld' \
      CXXFLAGS='-flto -pipe -O3 -static -fuse-ld=lld' \
      LDFLAGS='#{@ldflags}'"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @git_bashd_env = <<~GIT_BASHD_EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    GIT_BASHD_EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/git", @git_bashd_env)
  end
end
