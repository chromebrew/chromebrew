require 'package'

class Cronie < Package
  description 'Cronie contains the standard UNIX daemon crond that runs specified programs at scheduled times and related tools.'
  homepage 'https://github.com/cronie-crond/cronie'
  version '1.5.2'
  license 'ISC, BSD, BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/cronie-crond/cronie/releases/download/cronie-1.5.2/cronie-1.5.2.tar.gz'
  source_sha256 '370bf34641691489330e708bd4cdbd779267296a030668a12f77b7e36872fd75'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '0d44284894af0f7bf322aa649755a146cc4159b27480f5b635862cbe0fdd3d56',
     armv7l: '0d44284894af0f7bf322aa649755a146cc4159b27480f5b635862cbe0fdd3d56',
       i686: '1c61635b8bdeb5dc1ee5dd4ccbe6c9bce49e6ce25f48568fdac928875d93ef56',
     x86_64: '28117939c3609d603068e21c5c16149d43677369c3660e3980705cd4ca98aede'
  })

  depends_on 'psmisc'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           '--without-selinux',
           '--without-pam'
    system 'make'
    @startcrond = <<~STARTCRONDEOF
      #!/bin/bash
      XDG_RUNTIME_DIR=/var/run/chrome
      BROADWAY_DISPLAY=:5
      CROND=$CREW_PREFIX/sbin/crond
      CRON=$(pidof $CROND 2> /dev/null)
      if [ -z "$CRON" ]; then
        sudo $CROND
        sleep 3
      fi
      CRON=$(pidof $CROND 2> /dev/null)
      if [ ! -z "$CRON" ]; then
        echo "crond process $CRON is running"
      else
        echo "crond failed to start"
        exit 1
      fi
    STARTCRONDEOF
    File.write('startcrond', @startcrond)
    @stopcrond = <<~STOPCRONDEOF
      #!/bin/bash
      CROND=$CREW_PREFIX/sbin/crond
      CRON=$(pidof $CROND 2> /dev/null)
      if [ ! -z "$CRON" ]; then
        sudo killall $CROND
        sleep 3
      fi
      CRON=$(pidof $CROND 2> /dev/null)
      if [ -z "$CRON" ]; then
        echo "crond process stopped"
      else
        echo "crond process $CRON is running"
        exit 1
      fi
    STOPCRONDEOF
    File.write('stopcrond', @stopcrond)
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/var/spool/cron"
    FileUtils.touch "#{CREW_DEST_PREFIX}/var/spool/cron/root"
    FileUtils.install 'startcrond', "#{CREW_DEST_PREFIX}/bin/startcrond", mode: 0o755
    FileUtils.install 'stopcrond', "#{CREW_DEST_PREFIX}/bin/stopcrond", mode: 0o755
  end

  def self.postinstall
    puts
    puts 'To start the crond daemon, execute the following:'.lightblue
    puts 'startcrond'.lightblue
    puts
    puts 'To stop the crond daemon, execute the following:'.lightblue
    puts 'stopcrond'.lightblue
    puts
    puts 'To create/edit a cron task, execute the following:'.lightblue
    puts 'sudo crontab -e'.lightblue
    puts
    puts 'To list cron tasks, execute the following:'.lightblue
    puts 'sudo crontab -l'.lightblue
    puts
    puts "echo '# start the crond daemon' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/startcrond ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/startcrond' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
  end
end
