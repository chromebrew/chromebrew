require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.32.0'
  version @_ver
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '004697482b6e3b0ae9147580c32efd35869426227f1526f8eafa7950c31def94'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0_armv7l/git-2.32.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0_armv7l/git-2.32.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0_i686/git-2.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0_x86_64/git-2.32.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd72074c725dd003aec3eaacc0523c069f6f1c8462291eba04ad625d1d0b37092',
     armv7l: 'd72074c725dd003aec3eaacc0523c069f6f1c8462291eba04ad625d1d0b37092',
       i686: '4cfb83ce6243baaaa74c309e0bbda22c62fdf57d99d294936b738a4be8ce9550',
     x86_64: '8d08dd84e5f16a11671bd387d2b5ec33ec2474dcf1d948c5d15474fe6afc7c2c'
  })

  depends_on 'libcurl' => :build

  def self.build
    abort('Please remove libiconv before building.') if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    @curl_static_libs = `curl-config --static-libs`.chomp.gsub('=auto', '')
    @sasl2_static_libs = "#{CREW_LIB_PREFIX}/libdb.a #{CREW_LIB_PREFIX}/libsasl2.a " + `pkg-config --libs --static libsasl2`.chomp
    @krb5_static_libs = "#{CREW_LIB_PREFIX}/libkrb5support.a #{CREW_LIB_PREFIX}/libgssapi_krb5.a #{CREW_LIB_PREFIX}/libkrb5.a #{CREW_LIB_PREFIX}/libk5crypto.a #{CREW_LIB_PREFIX}/libcom_err.a"
    @ldflags = "-flto -static -L#{CREW_LIB_PREFIX} #{CREW_LIB_PREFIX}/libssl.a #{CREW_LIB_PREFIX}/libcrypto.a #{@krb5_static_libs} #{CREW_LIB_PREFIX}/libcurl.a #{@sasl2_static_libs} -lgmp #{@curl_static_libs} -lunistring -Wl,--no-as-needed -ldl"

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
