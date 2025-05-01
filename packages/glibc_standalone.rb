require 'package'

class Glibc_standalone < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.41-2'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/glibc/glibc-#{version.partition('-')[0]}.tar.xz"
  source_sha256 'a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e19d852da8d4ead346d62003f9e5f15076ed5fae5bcd12dc9bd8f7f2602bc1b2',
     armv7l: 'e19d852da8d4ead346d62003f9e5f15076ed5fae5bcd12dc9bd8f7f2602bc1b2',
       i686: '5b3a5e7256520a0435604b53f93a743d58ea07bea950fe3ee5f371c296f640f1',
     x86_64: '44220b48699ab3fb677d16c0b5172fac151c47edfa48015f170633a5a1dd18ed'
  })

  depends_on 'gawk' => :build
  depends_on 'filecmd' # L Fixes creating symlinks on a fresh install.
  depends_on 'libidn2' => :build
  depends_on 'llvm' => :build
  depends_on 'texinfo' => :build
  depends_on 'libxcrypt' # Latest glibc removed libcrypt.so, add this for backward compatibility
  depends_on 'patchelf' # L
  depends_on 'glibc' # R

  conflicts_ok
  no_env_options
  no_shrink
  print_source_bashrc

  def self.patch
    system "git clone --depth=1 https://github.com/chromebrew/crew-package-glibc -b #{version}"
    system 'filefix'

    Dir.glob('crew-package-glibc/patches/*.patch') do |patch|
      puts "Applying #{patch}...".yellow
      system 'patch', '-p1', '-i', patch
    end
  end

  def self.build
    cc_macro_list = %W[
      -DCREW_AUDIT=\\"#{CREW_GLIBC_PREFIX}/crew-audit.so\\"
      -DCREW_PREFIX=\\"#{CREW_PREFIX}\\"
      -DCREW_GLIBC_PREFIX=\\"#{CREW_GLIBC_PREFIX}\\"
      -DCREW_GLIBC_VERSION=\\"#{version.partition('-')[0]}\\"
      -DCREW_LD_LIBRARY_PATH=\\"#{CREW_GLIBC_PREFIX}:#{ENV.fetch('LD_LIBRARY_PATH', nil)}\\"
    ]

    build_env = {
      CFLAGS:   "-O3 -pipe -fPIC -fno-lto -fuse-ld=lld #{cc_macro_list.join(' ')}",
      CXXFLAGS: "-O3 -pipe -fPIC -fno-lto -fuse-ld=lld #{cc_macro_list.join(' ')}",
      LDFLAGS:  '-fno-lto -fuse-ld=lld',
      LD:       'ld.lld' # use lld here as mold will segfault
    }

    config_opts = %W[
      --prefix=#{CREW_PREFIX}
      --libdir=#{CREW_GLIBC_PREFIX}
      --libexecdir=#{CREW_PREFIX}/libexec
      --mandir=#{CREW_PREFIX}/share/man
      --with-headers=#{CREW_PREFIX}/include
      --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new
      --enable-bind-now
      --enable-fortify-source
      --enable-kernel=3.2
      --disable-nscd
      --disable-profile
      --disable-sanity-checks
      --disable-werror
      --without-cvs
      --without-selinux
    ]

    config_opts << '--enable-cet' unless ARCH == 'i686'

    FileUtils.mkdir_p 'builddir'
    Dir.chdir('builddir') do
      File.write 'configparms', <<~EOF
        slibdir=#{CREW_GLIBC_PREFIX}
        rtlddir=#{CREW_GLIBC_PREFIX}
        sbindir=#{CREW_PREFIX}/bin
        rootsbindir=#{CREW_PREFIX}/bin
      EOF

      system build_env.transform_keys(&:to_s), '../configure', *config_opts
      system "make PARALLELMFLAGS='-j #{CREW_NPROC}'"
    end

    # compile crew-audit with system's glibc version, as we want it to work on system's glibc also
    system "cc #{CREW_COMMON_FLAGS.sub(/-L[^\s]+/, '')} #{cc_macro_list.join(' ')} -shared crew-audit.c -o crew-audit.so", chdir: 'crew-package-glibc'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d"

    system "make DESTDIR=#{CREW_DEST_DIR} install", chdir: 'builddir'
    system "make DESTDIR=#{CREW_DEST_DIR} localedata/install-locales", chdir: 'builddir'

    # install crew-audit
    FileUtils.install 'crew-package-glibc/crew-audit.so', File.join(CREW_DEST_DIR, CREW_GLIBC_PREFIX, 'crew-audit.so'), mode: 0o755
    File.write "#{CREW_DEST_PREFIX}/etc/env.d/10-glibc", "LD_AUDIT=#{File.join(CREW_GLIBC_PREFIX, 'crew-audit.so')}\n"
  end

  def self.postinstall
    # update search cache for ld.so
    FileUtils.cp '/etc/ld.so.conf', "#{CREW_PREFIX}/etc/ld.so.conf"
    File.write "#{CREW_PREFIX}/etc/ld.so.conf", "#{CREW_GLIBC_PREFIX}\n", mode: 'a'
    system "#{CREW_GLIBC_PREFIX}/ldconfig"
  end
end
