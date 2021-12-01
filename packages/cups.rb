require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://github.com/OpenPrinting/cups'
  @_ver = '2.4.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.0_armv7l/cups-2.4.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.0_armv7l/cups-2.4.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.0_i686/cups-2.4.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.0_x86_64/cups-2.4.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '13db998ba3942d45c7d73b74bf6b4fc562b5bb04a4f57c9228dc5bf31f9e78b8',
     armv7l: '13db998ba3942d45c7d73b74bf6b4fc562b5bb04a4f57c9228dc5bf31f9e78b8',
       i686: '61bbd54311f8d7b3970b838b8483a8599ae24f6728b9987c8e7a739daaf6b575',
     x86_64: '7f26cef90ae5e9f8b30d18682a707946a1ef174af0118650f93010fb3f9723b8'
  })

  depends_on 'libusb'
  depends_on 'linux_pam'
  depends_on 'psmisc'
  depends_on

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --enable-libusb"
    system 'make'
    system "echo '#!/bin/bash' > startcupsd"
    system "echo 'CUPSD=#{CREW_PREFIX}/sbin/cupsd' >> startcupsd"
    system "echo 'CUPS=\$(pidof \$CUPSD 2> /dev/null)' >> startcupsd"
    system "echo 'if [ -z \"\$CUPS\" ]; then' >> startcupsd"
    system "echo '  \$CUPSD' >> startcupsd"
    system "echo '  sleep 3' >> startcupsd"
    system "echo 'fi' >> startcupsd"
    system "echo 'CUPS=\$(pidof \$CUPSD 2> /dev/null)' >> startcupsd"
    system "echo 'if [ ! -z \"\$CUPS\" ]; then' >> startcupsd"
    system "echo '  echo \"cupsd process \$CUPS is running\"' >> startcupsd"
    system "echo 'else' >> startcupsd"
    system "echo '  echo \"cupsd failed to start\"' >> startcupsd"
    system "echo '  exit 1' >> startcupsd"
    system "echo 'fi' >> startcupsd"
    system "echo '#!/bin/bash' > stopcupsd"
    system "echo 'CUPSD=#{CREW_PREFIX}/sbin/cupsd' >> stopcupsd"
    system "echo 'CUPS=\$(pidof \$CUPSD 2> /dev/null)' >> stopcupsd"
    system "echo 'if [ ! -z \"\$CUPS\" ]; then' >> stopcupsd"
    system "echo '  killall \$CUPSD' >> stopcupsd"
    system "echo '  sleep 3' >> stopcupsd"
    system "echo 'fi' >> stopcupsd"
    system "echo 'CUPS=\$(pidof \$CUPSD 2> /dev/null)' >> stopcupsd"
    system "echo 'if [ -z \"\$CUPS\" ]; then' >> stopcupsd"
    system "echo '  echo \"cupsd process stopped\"' >> stopcupsd"
    system "echo 'else' >> stopcupsd"
    system "echo '  echo \"cupsd process \$CUPS is running\"' >> stopcupsd"
    system "echo '  exit 1' >> stopcupsd"
    system "echo 'fi' >> stopcupsd"
  end

  def self.install
    system 'make',
           "DESTDIR=#{CREW_DEST_DIR}",
           "DATADIR=#{CREW_DEST_PREFIX}/share/cups",
           "DOCDIR=#{CREW_DEST_PREFIX}/share/doc/cups",
           "MANDIR=#{CREW_DEST_PREFIX}/share/man",
           "ICONDIR=#{CREW_PREFIX}/share/icons",
           "MENUDIR=#{CREW_PREFIX}/share/applications",
           "INITDIR=#{CREW_PREFIX}/etc/init.d",
           "SERVERROOT=#{CREW_DEST_PREFIX}/etc/cups",
           "SERVERBIN=#{CREW_DEST_PREFIX}/libexec/cups",
           "CACHEDIR=#{CREW_DEST_PREFIX}/var/cache/cups",
           "LOCALEDIR=#{CREW_DEST_PREFIX}/share/locale",
           'install'
    system "install -Dm755 startcupsd #{CREW_DEST_PREFIX}/bin/startcupsd"
    system "install -Dm755 stopcupsd #{CREW_DEST_PREFIX}/bin/stopcupsd"
    if File.exist?("#{CREW_DEST_DIR}/etc/dbus-1/system.d/cups.conf")
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/dbus-1/system.d"
      FileUtils.mv "#{CREW_DEST_DIR}/etc/dbus-1/system.d/cups.conf", "#{CREW_DEST_PREFIX}/share/dbus-1/system.d/"
    end
    if File.exist?("#{CREW_DEST_DIR}/etc/pam.d/cups")
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/pam.d"
      FileUtils.mv "#{CREW_DEST_DIR}/etc/pam.d/cups", "#{CREW_DEST_PREFIX}/etc/pam.d/"
    end
  end

  def self.postinstall
    puts
    puts "To start the cups daemon, run 'startcupsd'".lightblue
    puts "To stop the cups daemon, run 'stopcupsd'".lightblue
    puts
    puts 'For more information, see https://docs.oracle.com/cd/E23824_01/html/821-1451/gllgm.html'.lightblue
    puts
  end
end
