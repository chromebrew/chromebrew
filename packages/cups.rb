require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://openprinting.github.io/cups'
  version '2.4.14'
  compatibility 'all'
  license 'Apache-2.0'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4aacbc9fe7e169a65337e84848fc2b3c28ef790a7280dac7b83a185f62f96cc1',
     armv7l: '4aacbc9fe7e169a65337e84848fc2b3c28ef790a7280dac7b83a185f62f96cc1',
       i686: '23932827ac7ad296e4eb0a1264d11323741f147875a0965bdae36af14d99a08e',
     x86_64: '8327ac7e2f24efc25ad4cf545e61f3a941ea4aa4728374961326d6f6594afdb0'
  })

  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libusb' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R
  depends_on 'llvm_dev' => :build if %w[armv7l aarch64].include?(ARCH)
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
    ExitMessage.add <<~EOM

      To start the cups daemon, run 'startcupsd'
      To stop the cups daemon, run 'stopcupsd'
      For more information, see https://www.cups.org/doc/admin.html.

    EOM
  end
end
