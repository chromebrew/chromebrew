require 'package'

class Cronie < Package
  description 'Cronie contains the standard UNIX daemon crond that runs specified programs at scheduled times and related tools.'
  homepage 'https://github.com/cronie-crond/cronie'
  version '1.5.2'
  compatibility 'all'
  source_url 'https://github.com/cronie-crond/cronie/releases/download/cronie-1.5.2/cronie-1.5.2.tar.gz'
  source_sha256 '370bf34641691489330e708bd4cdbd779267296a030668a12f77b7e36872fd75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cronie-1.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cronie-1.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cronie-1.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cronie-1.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0d44284894af0f7bf322aa649755a146cc4159b27480f5b635862cbe0fdd3d56',
     armv7l: '0d44284894af0f7bf322aa649755a146cc4159b27480f5b635862cbe0fdd3d56',
       i686: '1c61635b8bdeb5dc1ee5dd4ccbe6c9bce49e6ce25f48568fdac928875d93ef56',
     x86_64: '28117939c3609d603068e21c5c16149d43677369c3660e3980705cd4ca98aede',
  })

  depends_on 'psmisc'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--without-selinux',
           '--without-pam'
    system 'make'
    system "echo '#!/bin/bash' > startcrond"
    system "echo 'CROND=#{CREW_PREFIX}/sbin/crond' >> startcrond"
    system "echo 'CRON=\$(pidof \$CROND 2> /dev/null)' >> startcrond"
    system "echo 'if [ -z \"\$CRON\" ]; then' >> startcrond"
    system "echo '  sudo \$CROND' >> startcrond"
    system "echo '  sleep 3' >> startcrond"
    system "echo 'fi' >> startcrond"
    system "echo 'CRON=\$(pidof \$CROND 2> /dev/null)' >> startcrond"
    system "echo 'if [ ! -z \"\$CRON\" ]; then' >> startcrond"
    system "echo '  echo \"crond process \$CRON is running\"' >> startcrond"
    system "echo 'else' >> startcrond"
    system "echo '  echo \"crond failed to start\"' >> startcrond"
    system "echo '  exit 1' >> startcrond"
    system "echo 'fi' >> startcrond"
    system "echo '#!/bin/bash' > stopcrond"
    system "echo 'CROND=#{CREW_PREFIX}/sbin/crond' >> stopcrond"
    system "echo 'CRON=\$(pidof \$CROND 2> /dev/null)' >> stopcrond"
    system "echo 'if [ ! -z \"\$CRON\" ]; then' >> stopcrond"
    system "echo '  sudo killall \$CROND' >> stopcrond"
    system "echo '  sleep 3' >> stopcrond"
    system "echo 'fi' >> stopcrond"
    system "echo 'CRON=\$(pidof \$CROND 2> /dev/null)' >> stopcrond"
    system "echo 'if [ -z \"\$CRON\" ]; then' >> stopcrond"
    system "echo '  echo \"crond process stopped\"' >> stopcrond"
    system "echo 'else' >> stopcrond"
    system "echo '  echo \"crond process \$CRON is running\"' >> stopcrond"
    system "echo '  exit 1' >> stopcrond"
    system "echo 'fi' >> stopcrond"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/var/spool/cron"
    system "touch #{CREW_DEST_PREFIX}/var/spool/cron/root"
    system "install -Dm755 startcrond #{CREW_DEST_PREFIX}/bin/startcrond"
    system "install -Dm755 stopcrond #{CREW_DEST_PREFIX}/bin/stopcrond"
  end

  def self.postinstall
    puts
    puts "To start the crond daemon, execute the following:".lightblue
    puts "startcrond".lightblue
    puts
    puts "To stop the crond daemon, execute the following:".lightblue
    puts "stopcrond".lightblue
    puts
    puts "To create/edit a cron task, execute the following:".lightblue
    puts "sudo crontab -e".lightblue
    puts
    puts "To list cron tasks, execute the following:".lightblue
    puts "sudo crontab -l".lightblue
    puts
    puts "To start the crond daemon at login, execute the following:".lightblue
    puts "echo '# start the crond daemon' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/startcrond ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/startcrond' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
