require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://github.com/OpenPrinting/cups'
  version '2.4.11'
  compatibility 'all'
  license 'Apache-2.0'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '418860e229680e2888764d14bac8bb4beeb7c562cd60696b4eb9b81082f43baa',
     armv7l: '418860e229680e2888764d14bac8bb4beeb7c562cd60696b4eb9b81082f43baa',
       i686: '7e000bd57ce514ffb1b50808d366ddb230d68ffe0f47a0fb5e19cfa4f216ca73',
     x86_64: '580c67be4ecf77554096dc7c351ea7c118cb4b7801357154137e733a2d4cd7a1'
  })

  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libusb' # R
  depends_on 'linux_pam' # R
  depends_on 'llvm20_dev' => :build if %w[armv7l aarch64].include?(ARCH)
  depends_on 'openssl' # R
  depends_on 'psmisc' # L
  depends_on 'zlib' # R

  no_env_options
  no_fhs

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
           "DESTDIR=#{CREW_DEST_DIR}",
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
           'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
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
    ExitMessage.add <<~EOM.lightblue

      To start the cups daemon, run 'startcupsd'
      To stop the cups daemon, run 'stopcupsd'
      For more information, see https://www.cups.org/doc/admin.html.

    EOM
  end
end
