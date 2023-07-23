require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://github.com/OpenPrinting/cups'
  version '2.4.6'
  compatibility 'all'
  license 'Apache-2.0'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.6_armv7l/cups-2.4.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.6_armv7l/cups-2.4.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.6_i686/cups-2.4.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.6_x86_64/cups-2.4.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '832ba0f47a1fe81dd0bc55a74971c55a4b98cec9ced02d9dfd6b7589cf4e6f74',
     armv7l: '832ba0f47a1fe81dd0bc55a74971c55a4b98cec9ced02d9dfd6b7589cf4e6f74',
       i686: 'bbb70f7d8d3f6df469b50727f372a4fa77160b2d948b7bb0ebe706047a9f489c',
     x86_64: 'da15e61c01c1f5ac7c3b156ce1640d14b1b2a6ebe1bcaba5051acee2fc9d8589'
  })

  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libusb' # R
  depends_on 'linux_pam' # R
  depends_on 'llvm16_dev' => :build if %w[armv7l aarch64].include?(ARCH)
  depends_on 'openssl' # R
  depends_on 'psmisc' # L
  depends_on 'zlibpkg' # R

  no_env_options
  no_fhs

  def self.build
    @buildoverride = %w[armv7l aarch64].include?(ARCH) ? 'CC=clang CXX=clang++ LD=mold CUPS_LINKER=mold' : ''
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
