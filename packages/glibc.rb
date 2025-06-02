require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.41-5'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  source_url 'https://sourceware.org/git/glibc.git'
  git_hashtag '515d4166f4dbcf43b1568e3f63a19d9a92b2d50e' # Build from latest commit in the stable branch.
  # source_url "https://ftpmirror.gnu.org/glibc/glibc-#{version.partition('-')[0]}.tar.xz"
  # source_sha256 'a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a0b690ce6975515c6b0d4cb39d64bc276975e3b3b15996320cd8cc216f381ca0',
     armv7l: 'a0b690ce6975515c6b0d4cb39d64bc276975e3b3b15996320cd8cc216f381ca0',
       i686: '061e30fa5ec7c5d83cf40e3d9b9ca858b7a88dda68b65bec3aac2da6d45aa6ff',
     x86_64: '632426d744b78b8941ce9348b7eb8d680d4c48780c6559a203998b0c4416fda1'
  })

  binary_sha256({
    aarch64: '8d092cdeeaf3b321b64b31cb76aa3813adf8e73416f4db557d41f0c0811e0131',
     armv7l: '8d092cdeeaf3b321b64b31cb76aa3813adf8e73416f4db557d41f0c0811e0131',
       i686: '8c2430f690f468f33dc849cd0b2163dfadf187ff1cc3e33f1d20cbfb06572ec3',
     x86_64: '50729b68b70aceb95f467812950fc58ec29e3e8b184f95d7c7b4ce7cb2d53946'
  })

  depends_on 'crew_preload' # L
  depends_on 'gawk'    => :build
  depends_on 'libidn2' => :build
  depends_on 'make' => :build
  depends_on 'patchelf' => :build
  depends_on 'texinfo' => :build
  depends_on 'libxcrypt' # Latest glibc removed libcrypt.so, add this for backward compatibility

  conflicts_ok
  no_env_options
  no_shrink
  print_source_bashrc

  def self.patch
    system 'git config --global advice.detachedHead false'
    system "git clone --depth=1 https://github.com/chromebrew/crew-package-glibc -b #{version}"

    Dir.glob('crew-package-glibc/patches/*.patch') do |patch|
      puts "Applying #{patch}...".yellow
      system 'patch', '-p1', '-i', patch
    end
    system 'filefix'

    # These are the only locales we want.
    @locales = %w[C cs_CZ de_DE en es_MX fa_IR fr_FR it_IT ja_JP ru_RU tr_TR zh].to_set
    puts 'Paring locales to a minimal set before build.'.lightblue

    localetypes = `awk -F '/' '{print $2}' localedata/SUPPORTED | sort -u | awk '{print $1}'`.split.flat_map(&:split)
    localetypes_sed = localetypes.join('|')
    Dir['localedata/{*.in,locales/*}'].compact.each do |f|
      g = File.basename(f).gsub(/.UTF-8.*.in/, '').gsub(/.ISO-8859-.*.in/, '')
      h = g.gsub(/_.*/, '')
      locale_test = [g, h].uniq
      # Just check to see if the set difference is smaller than the
      # original set of locales.
      if (@locales - locale_test).length < @locales.length
        puts "Saving locale: #{f}"
      else
        system "sed -i -r '/^[[:space:]]#{g}.*(#{localetypes_sed}).*\\\\/d' localedata/Makefile", exception: false
        system "sed -i -r '/^#{g}.*(#{localetypes_sed}).*\\\\/d' localedata/SUPPORTED", exception: false
      end
    end
    @workdir = `pwd`.chomp
    Dir.chdir('crew-package-glibc/archlinux') do
      system "sed -i 's,/etc/,#{`pwd`.chomp}/,g' *"
      system "sed -i 's,/usr/lib,#{CREW_DEST_LIB_PREFIX},g' *"
      system "sed -i 's,/usr/share,#{CREW_DEST_PREFIX}/share,g' *"
      # Use our locally built localedef during install.
      system "sed -i 's,localedef,#{@workdir}/builddir/locale/localedef --prefix=#{CREW_DEST_DIR},' locale-gen"
    end
    system "sed -e '1,3d' -e 's|/| |g' -e 's|\\\\| |g' -e 's|^|#|g' localedata/SUPPORTED >> crew-package-glibc/archlinux/locale.gen"
  end

  def self.build
    cc_macro_list = %W[
      -DCREW_PREFIX=\\"#{CREW_PREFIX}\\"
      -DCREW_GLIBC_PREFIX=\\"#{CREW_GLIBC_PREFIX}\\"
      -DCREW_GLIBC_INTERPRETER=\\"#{CREW_GLIBC_INTERPRETER}\\"
    ]

    build_env = {
      CFLAGS:   "-O3 -pipe -fPIC -fno-lto #{cc_macro_list.join(' ')}",
      CXXFLAGS: "-O3 -pipe -fPIC -fno-lto #{cc_macro_list.join(' ')}",
      LDFLAGS:  '-fno-lto',
   LD_PRELOAD: ''
    }

    config_opts = %W[
      --prefix=#{CREW_PREFIX}
      --libdir=#{CREW_LIB_PREFIX}
      --mandir=#{CREW_MAN_PREFIX}
      --with-headers=#{CREW_PREFIX}/include
      --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new
      --enable-bind-now
      --enable-fortify-source
      --enable-kernel=3.2
      --enable-shared
      --disable-nscd
      --disable-multilib
      --disable-profile
      --disable-sanity-checks
      --disable-werror
      --without-cvs
      --without-selinux
    ]

    config_opts << '--enable-cet' unless ARCH == 'i686'

    FileUtils.mkdir_p %w[builddir]

    Dir.chdir('builddir') do
      File.write 'configparms', <<~EOF
        slibdir=#{CREW_GLIBC_PREFIX}
        rtlddir=#{CREW_GLIBC_PREFIX}
        sbindir=#{CREW_PREFIX}/bin
        rootsbindir=#{CREW_PREFIX}/bin
      EOF

      system build_env.transform_keys(&:to_s), '../configure', *config_opts, no_preload_hacks: true
      system "make PARALLELMFLAGS='-j #{CREW_NPROC}'", no_preload_hacks: true
    end
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/etc/env.d #{CREW_DEST_PREFIX}/etc/ld.so.conf.d #{CREW_DEST_PREFIX}/share #{CREW_DEST_LIB_PREFIX} #{CREW_DEST_LIB_PREFIX}/locale]

    system "make DESTDIR=#{CREW_DEST_DIR} install", chdir: 'builddir'

    # Avoid conflicts with the zoneinfo tzdata package:
    %w[tzselect zdump zic].each { |f| FileUtils.rm_rf "#{CREW_DEST_PREFIX}/bin/#{f}" }

    @interpreter = case ARCH
                   when 'aarch64', 'armv7l'
                     "#{CREW_DEST_PREFIX}/opt/glibc-libs/ld-linux-armhf.so.3"
                   when 'i686'
                     "#{CREW_DEST_PREFIX}/opt/glibc-libs/ld-linux.so.2"
                   when 'x86_64'
                     "#{CREW_DEST_PREFIX}/opt/glibc-libs/ld-linux-x86-64.so.2"
                   end
    # We need to set make and localedef to work with this newly built
    # glibc.
    FileUtils.cp "#{CREW_PREFIX}/bin/make", 'builddir/make'
    system(<<~INSTALL_LOCALES_EOF, chdir: 'builddir')
      patchelf --set-interpreter #{@interpreter} make
      patchelf --replace-needed libdl.so.2 #{CREW_DEST_PREFIX}/opt/glibc-libs/libdl.so.2 make
      patchelf --replace-needed libc.so.6 #{CREW_DEST_PREFIX}/opt/glibc-libs/libc.so.6 make
      patchelf --set-interpreter #{@interpreter} locale/localedef
      patchelf --add-needed #{CREW_DEST_PREFIX}/opt/glibc-libs/libdl.so.2 locale/localedef
      patchelf --replace-needed libc.so.6 #{CREW_DEST_PREFIX}/opt/glibc-libs/libc.so.6 locale/localedef
      ./make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locales
      ./make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locale-files
    INSTALL_LOCALES_EOF
    system "sed -e '1,3d' -e 's|/| |g' -e 's| \\\\||g' localedata/SUPPORTED > #{CREW_DEST_PREFIX}/share/i18n/SUPPORTED"
    system 'crew-package-glibc/archlinux/locale-gen'

    File.write "#{CREW_DEST_PREFIX}/etc/ld.so.conf", <<~EOF
      # ld.so.conf autogenerated by Chromebrew
      # DO NOT put your changes here. Instead, put them in
      # #{CREW_PREFIX}/etc/ld.so.conf.d/ instead.

      include #{CREW_PREFIX}/etc/ld.so.conf.d/*.conf
      #{CREW_GLIBC_PREFIX}
      #{CREW_LIB_PREFIX}
      include /etc/ld.so.conf
    EOF
  end

  def self.postinstall
    # update search cache for ld.so
    system "#{CREW_PREFIX}/bin/ldconfig", %i[out err] => File::NULL
  end
end
