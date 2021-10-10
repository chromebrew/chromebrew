require 'package'

class Firefox < Package
  description 'Mozilla Firefox (or simply Firefox) is a free and open-source web browser.'
  homepage 'https://www.mozilla.org/en-US/firefox/'
  @_ver = '93.0'
  version @_ver
  license 'MPL-2.0, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://archive.mozilla.org/pub/firefox/releases/#{@_ver}/source/firefox-#{@_ver}.source.tar.xz"
  source_sha256 'a78f080f5849bc284b84299f3540934a12e961a7ea368b592ae6576ea1f97102'

  depends_on 'cbindgen' => :build
  depends_on 'node' => :build
  depends_on 'rust' => :build
  depends_on 'nasm' => :build
  depends_on 'nss'
  depends_on 'nspr'
  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'gtk3'
  depends_on 'gdk_pixbuf'
  depends_on 'libpng'
  depends_on 'mesa'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'pulseaudio'
  depends_on 'pixman'
  depends_on 'glib'
  depends_on 'zlibpkg'
  depends_on 'libffi'
  depends_on 'libx11'
  depends_on 'libxcomposite'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxrender'
  depends_on 'dbus_glib'
  depends_on 'dav1d'
  depends_on 'libaom'
  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'libevent'
  depends_on 'libjpeg'
  depends_on 'libvpx'
  depends_on 'libwebp'
  depends_on 'libx264'
  depends_on 'sommelier'

  def self.patch
    system "curl -#LO https://dev.gentoo.org/~whissi/mozilla/patchsets/firefox-93-patches-01.tar.xz"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("firefox-93-patches-01.tar.xz") ) == 'bf94adebac44c9b0192206080e1749a8ab913e85baf67c15bce46d0ef7f7a8a2'
    system 'tar xf firefox-93-patches-01.tar.xz'
    system 'for i in firefox-patches/*.patch; do patch -Np1 -i ${i}; done'
  end

  def self.build
    # TODO: Add API keys
    system "find ./third_party -type f -name '*.so' -o -name '*.o' -print -delete"
    FileUtils.mkdir_p "firefox_build"
    @_mozconfig = <<~EOF
      ac_add_options --allow-addon-sideload
      ac_add_options --disable-cargo-incremental
      ac_add_options --disable-crashreporter
      ac_add_options --disable-install-strip
      ac_add_options --disable-strip
      ac_add_options --disable-updater
      ac_add_options --enable-official-branding
      ac_add_options --enable-release
      ac_add_options --enable-system-ffi
      ac_add_options --enable-system-pixman
      ac_add_options --enable-dbus
      ac_add_options --enable-pulseaudio
      ac_add_options --libdir="#{CREW_LIB_PREFIX}"
      ac_add_options --prefix="#{CREW_PREFIX}"
      ac_add_options --target="#{CREW_TGT}"
      ac_add_options --host="#{CREW_TGT}"
      ac_add_options --without-ccache
      ac_add_options --with-intl-api
      ac_add_options --with-system-nspr
      ac_add_options --with-system-nss
      ac_add_options --with-system-png
      ac_add_options --with-system-zlib
      ac_add_options --with-system-av1
      ac_add_options --with-system-harfbuzz
      ac_add_options --with-system-graphite2
      ac_add_options --with-system-icu
      #ac_add_options --with-system-jpeg
      ac_add_options --with-system-libevent
      ac_add_options --with-system-libvpx
      ac_add_options --with-system-webp
      ac_add_options --enable-default-toolkit=cairo-gtk3
      ac_add_options --enable-lto=full
      ac_add_options --enable-linker=gold
      ac_add_options --enable-optimize="-O2"
      ac_add_options --disable-debug-symbols
      ac_add_options MOZ_PGO=1
      ac_add_options --with-unsigned-addon-scopes=app,system
      ac_add_options --x-includes="#{CREW_PREFIX}/includes"
      ac_add_options --x-libraries="#{CREW_LIB_PREFIX}"
      export RUSTC_OPT_LEVEL=2
    EOF
    IO.write(".mozconfig", @_mozconfig)

    system "env MOZILLA_FIVE_HOME='#{CREW_LIB_PREFIX}/firefox' \
                CC='#{CREW_TGT}-gcc' CXX='#{CREW_TGT}-g++' LD='#{CREW_TGT}-ld.gold' AR=#{CREW_TGT}-gcc-ar NM=#{CREW_TGT}-gcc-nm RANLIB=#{CREW_TGT}-gcc-ranlib \
                SHELL='/bin/bash' \
                MOZCONFIG='.mozconfig' \
                MOZBUILD_STATE_PATH='.mozbuild' \
                MOZILLA_OFFICIAL=1 \
                LLVM_PROFDATA='llvm-profdata' \
                MACH_USE_SYSTEM_PYTHON=1 \
                ./mach configure"
    system "env MOZILLA_FIVE_HOME='#{CREW_LIB_PREFIX}/firefox' \
                CC='#{CREW_TGT}-gcc' CXX='#{CREW_TGT}-g++' LD='#{CREW_TGT}-ld.gold' AR=#{CREW_TGT}-gcc-ar NM=#{CREW_TGT}-gcc-nm RANLIB=#{CREW_TGT}-gcc-ranlib \
                SHELL='/bin/bash' \
                MOZCONFIG='.mozconfig' \
                MOZBUILD_STATE_PATH='.mozbuild' \
                MOZILLA_OFFICIAL=1 \
                LLVM_PROFDATA='llvm-profdata' \
                MACH_USE_SYSTEM_PYTHON=1 \
                GDK_BACKEND=x11 \
                ./mach build --verbose"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ./mach install"
    # TODO: port from equivalent gentoo ebuild
  end

  def self.postinstall
    print "\nSet Firefox as your default browser? [Y/n]: "
    case STDIN.getc
    when "\n", "Y", "y"
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'firefox', 'x-www-browser'
      end
      puts 'Firefox is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    puts "\nType 'firefox' to get started.\n".lightblue
  end
end
