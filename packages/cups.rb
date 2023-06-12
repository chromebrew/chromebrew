require 'package'

class Cups < Package
  description 'CUPS is the standards-based, open source printing system'
  homepage 'https://github.com/OpenPrinting/cups'
  version '2.4.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/OpenPrinting/cups.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.2_armv7l/cups-2.4.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.2_armv7l/cups-2.4.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.2_i686/cups-2.4.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cups/2.4.2_x86_64/cups-2.4.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4122b205373155bf4b4e66d6ac43676e1d3fd71809719f869bfc4413e8366d76',
     armv7l: '4122b205373155bf4b4e66d6ac43676e1d3fd71809719f869bfc4413e8366d76',
       i686: '69c5785cd4f409abe649ced3629640e0ae5421f7ded9783918be284905c23923',
     x86_64: 'b031e0dbf4bb329a60bac4db64bcd29dc561ce01c270b701afcf6582285e205e'
  })

  depends_on 'libusb'
  depends_on 'linux_pam'
  depends_on 'psmisc'

  def self.build
    system "./configure #{CREW_OPTIONS} \
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'startcupsd', "#{CREW_DEST_PREFIX}/bin/startcupsd", mode: 0o755
    FileUtils.install 'stopcupsd', "#{CREW_DEST_PREFIX}/bin/stopcupsd", mode: 0o755
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
    puts 'For more information, see https://www.cups.org/doc/admin.html'.lightblue
    puts
  end
end
