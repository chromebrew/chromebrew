require 'buildsystems/autotools'

class Cronie < Autotools
  description 'Cronie contains the standard UNIX daemon crond that runs specified programs at scheduled times and related tools.'
  homepage 'https://github.com/cronie-crond/cronie'
  version '1.7.2'
  license 'ISC, BSD, BSD-2 and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/cronie-crond/cronie.git'
  git_hashtag "cronie-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8f7ac38f695008bd34cfbfe975444fc84ac51712af27d80a34a0b0dcc226b8b',
     armv7l: 'd8f7ac38f695008bd34cfbfe975444fc84ac51712af27d80a34a0b0dcc226b8b',
       i686: '03af4fcc21ed26304a8661db7d3b1a1fd0143285f44537d6f5931d7b505966bc',
     x86_64: '272c2685c57a1cc9a6d9c2d917998a4cb1c04ee69867cf8b8b7a054c5515e177'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--without-selinux \
           --without-pam'
  autotools_build_extras do
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

  autotools_install_extras do
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
