require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://github.com/OpenPrinting/cups'
  version '2.4.5'
  compatibility 'all'
  license 'Apache-2.0'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.5_armv7l/cups-2.4.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.5_armv7l/cups-2.4.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.5_i686/cups-2.4.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.5_x86_64/cups-2.4.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c3b9b01548b1777198379b96cf0700157b630a97b3fce8b56992245cea84da91',
     armv7l: 'c3b9b01548b1777198379b96cf0700157b630a97b3fce8b56992245cea84da91',
       i686: '7098e7a9a29034da692c0ffab4c6163398bd9c453c7b986d3b114aa3a984d1ce',
     x86_64: 'e6ae23e3907b219d8cea4a86c9a88b0db03284810e89011e0d255fefc33d1199'
  })

  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libusb' # R
  depends_on 'linux_pam' # R
  depends_on 'llvm_dev' => :build if ARCH == 'armv7l' || ARCH == 'aarch64'
  depends_on 'openssl' # R
  depends_on 'psmisc' # L
  depends_on 'zlibpkg' # R

  no_env_options
  no_fhs

  def self.build
    @buildoverride = ARCH == 'armv7l' || ARCH == 'aarch64' ? 'CC=clang CXX=clang++ LD=mold CUPS_LINKER=mold' : ''
    system "#{@buildoverride} ./configure #{CREW_OPTIONS} \
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
    puts "\nTo start the cups daemon, run 'startcupsd'".lightblue
    puts "To stop the cups daemon, run 'stopcupsd'\n".lightblue
    puts "For more information, see https://www.cups.org/doc/admin.html.\n".lightblue
  end
end
