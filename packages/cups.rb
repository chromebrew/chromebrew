require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://github.com/OpenPrinting/cups'
  version '2.3.3op1'
  compatibility 'all'
  source_url 'https://github.com/OpenPrinting/cups/archive/v2.3.3op1.tar.gz'
  source_sha256 '64148c7f7c0d2b2715db1be2fb557042ccb0b0f19a03456a83fbf6353bb73c89'



  depends_on 'acl'
  depends_on 'krb5'
  depends_on 'libusb'
  depends_on 'linux_pam'
  depends_on 'psmisc'

  def self.build
    system "./configure #{CREW_OPTIONS} \
    --disable-launchd --disable-systemd \
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
    system "make",
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
        "install"
    system "install -Dm755 startcupsd #{CREW_DEST_PREFIX}/bin/startcupsd"
    system "install -Dm755 stopcupsd #{CREW_DEST_PREFIX}/bin/stopcupsd"
  end

  def self.postinstall
    puts
    puts "To start the cups daemon, run 'startcupsd'".lightblue
    puts "To stop the cups daemon, run 'stopcupsd'".lightblue
    puts
    puts "For more information, see https://docs.oracle.com/cd/E23824_01/html/821-1451/gllgm.html".lightblue
    puts
  end
end
