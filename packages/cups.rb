require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://openprinting.github.io/cups'
  version '2.4.19'
  compatibility 'all'
  license 'Apache-2.0'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '317969e2827c1702e7b44dd800727bf3ac25b5b2193245c96d13ad48a6fcda7c',
     armv7l: '317969e2827c1702e7b44dd800727bf3ac25b5b2193245c96d13ad48a6fcda7c',
       i686: '86a86eee0cfce1a285a63dfc33ad3d0114893ff3a85989f6ae95b47a9125ba68',
     x86_64: '057d17a9bccdd8daba89a20a4158865061180bc0b8908e77b784e8df1b6671b1'
  })

  depends_on 'acl' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libusb' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'linux_pam' => :executable
  depends_on 'llvm_dev' => :build if %w[armv7l aarch64].include?(ARCH)
  depends_on 'openssl' => :library
  depends_on 'psmisc' => :logical
  depends_on 'zlib' => :library

  no_env_options

  def self.build
    @buildoverride = %w[armv7l aarch64].include?(ARCH) ? 'CC=clang CXX=clang++ LD=mold CUPS_LINKER=mold' : ''
    system "#{@buildoverride} ./configure #{CREW_CONFIGURE_OPTIONS} \
      --enable-libusb"
    system 'make'
    File.write 'startcupsd', <<~EOF
      #!/bin/bash
      CUPSD=#{CREW_PREFIX}/sbin/cupsd
      CUPS=$(pidof "$CUPSD" 2> /dev/null)
      if [ -z "$CUPS" ]; then
        $CUPSD
        sleep 3
      fi
      CUPS=$(pidof "$CUPSD" 2> /dev/null)
      if [ -n "$CUPS" ]; then
        echo "cupsd process $CUPS is running"
      else
        echo "cupsd failed to start"
        exit 1
      fi
    EOF
    File.write 'stopcupsd', <<~EOF
      #!/bin/bash
      CUPSD=#{CREW_PREFIX}/sbin/cupsd
      CUPS=$(pidof "$CUPSD" 2> /dev/null)
      if [ -n "$CUPS" ]; then
        killall "$CUPSD"
        sleep 3
      fi
      CUPS=$(pidof "$CUPSD" 2> /dev/null)
      if [ -z "$CUPS" ]; then
        echo "cupsd process stopped"
      else
        echo "cupsd process $CUPS is running"
        exit 1
      fi
    EOF
  end

  def self.install
    system 'make',
           "PREFIX=#{CREW_PREFIX}",
           "DESTDIR=#{CREW_DEST_DIR}",
           "LIBDIR=#{CREW_DEST_LIB_PREFIX}",
           "DATADIR=#{CREW_DEST_PREFIX}/share/cups",
           "DOCDIR=#{CREW_DEST_PREFIX}/share/doc/cups",
           "MANDIR=#{CREW_DEST_MAN_PREFIX}",
           "ICONDIR=#{CREW_PREFIX}/share/icons",
           "MENUDIR=#{CREW_PREFIX}/share/applications",
           "INITDIR=#{CREW_PREFIX}/etc/init.d",
           "SERVERROOT=#{CREW_DEST_PREFIX}/etc/cups",
           "SERVERBIN=#{CREW_DEST_PREFIX}/libexec/cups",
           "CACHEDIR=#{CREW_DEST_PREFIX}/var/cache/cups",
           "LOCALEDIR=#{CREW_DEST_PREFIX}/share/locale",
           "CUPS_PKGCONFPATH=#{CREW_DEST_LIB_PREFIX}/pkgconfig",
           'install'
    FileUtils.install 'startcupsd', "#{CREW_DEST_PREFIX}/bin/startcupsd", mode: 0o755
    FileUtils.install 'stopcupsd', "#{CREW_DEST_PREFIX}/bin/stopcupsd", mode: 0o755
    if File.exist?("#{CREW_DEST_DIR}/etc/dbus-1/system.d/cups.conf")
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbus-1/system.d"
      FileUtils.mv "#{CREW_DEST_DIR}/etc/dbus-1/system.d/cups.conf", "#{CREW_DEST_PREFIX}/share/dbus-1/system.d/"
    end
    return unless File.exist?("#{CREW_DEST_DIR}/etc/pam.d/cups")

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/pam.d"
    FileUtils.mv "#{CREW_DEST_DIR}/etc/pam.d/cups", "#{CREW_DEST_PREFIX}/etc/pam.d/"
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      To start the cups daemon, run 'startcupsd'
      To stop the cups daemon, run 'stopcupsd'
      For more information, see https://www.cups.org/doc/admin.html.
    EOM
  end
end
