require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.31.1'
  version "#{@_ver}-2"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 'b1c0e95e9861b5d1b9ad3d8deaa2d8c7f02304ffc1b5e8869dd9fb98f9a0d436'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-2_armv7l/git-2.31.1-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-2_armv7l/git-2.31.1-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-2_i686/git-2.31.1-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.31.1-2_x86_64/git-2.31.1-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '497a3e7cc45f4a373a65b7d666484949d99ff4ec489cbfd67560abc8dd2f4560',
     armv7l: '497a3e7cc45f4a373a65b7d666484949d99ff4ec489cbfd67560abc8dd2f4560',
       i686: '502549508cbd7372d60a642021b50c73fd79a85b87cad9b332875d00f4c9db5e',
     x86_64: '8b081c8000ec4fb6f8856c48c1f5eb97cece1d857f4afb7e5051283cddf28c53'
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
