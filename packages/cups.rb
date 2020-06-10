require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://www.cups.org/'
  version '2.2.8'
  compatibility 'all'
  source_url 'https://github.com/apple/cups/releases/download/v2.2.8/cups-2.2.8-source.tar.gz'
  source_sha256 '3968fc1d26fc48727508db1c1380e36c6694ab90177fd6920aec5f6cc73af9e4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cups-2.2.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cups-2.2.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cups-2.2.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cups-2.2.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aeec9f3bb343b9f70359d8fa5c1c3074a03998bc802a04377cbc01506bcef242',
     armv7l: 'aeec9f3bb343b9f70359d8fa5c1c3074a03998bc802a04377cbc01506bcef242',
       i686: '5f9ff3495d40570cf8882a8a53f3815289c091c34bc2ab7b75185d38256ee280',
     x86_64: '59cdd35b557c5828c5ac58cc3173c96816ef525e0776ed107efe6c108ca98721',
  })

  depends_on 'acl'
  depends_on 'krb5'
  depends_on 'libusb'
  depends_on 'openpam'
  depends_on 'psmisc'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-launchd',
           '--disable-systemd',
           '--enable-libusb'
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
           "PREFIX=#{CREW_DEST_PREFIX}",
           "LIBDIR=#{CREW_DEST_LIB_PREFIX}",
           "BINDIR=#{CREW_DEST_PREFIX}/bin",
           "SBINDIR=#{CREW_DEST_PREFIX}/sbin",
           "INCLUDEDIR=#{CREW_DEST_PREFIX}/include",
           "DATADIR=#{CREW_DEST_PREFIX}/share/cups",
           "DOCDIR=#{CREW_DEST_PREFIX}/share/doc/cups",
           "MANDIR=#{CREW_DEST_PREFIX}/share/man",
           "ICONDIR=#{CREW_DEST_PREFIX}/share/icons",
           "MENUDIR=#{CREW_DEST_PREFIX}/share/applications",
           "INITDIR=#{CREW_DEST_PREFIX}/etc/init.d",
           "SERVERROOT=#{CREW_DEST_PREFIX}/etc/cups",
           "SERVERBIN=#{CREW_DEST_PREFIX}/libexec/cups",
           "CACHEDIR=#{CREW_DEST_PREFIX}/var/cache/cups",
           "LOCALEDIR=#{CREW_DEST_PREFIX}/share/locale",
           'install'
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
