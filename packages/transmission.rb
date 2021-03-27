require 'package'

class Transmission < Package
  description 'A fast, easy, and free BitTorrent client.'
  homepage 'https://transmissionbt.com/'
  version '2.94'
  license ' GPL-2, GPL-3 or Transmission-OpenSSL-exception, GPL-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/transmission/transmission-releases/raw/master/transmission-2.94.tar.xz'
  source_sha256 '35442cc849f91f8df982c3d0d479d650c6ca19310a994eccdaa79a4af3916b7d'

  depends_on 'curl'
  depends_on 'glib'
  depends_on 'gnome_icon_theme'
  depends_on 'hicolor_icon_theme'
  depends_on 'libevent'
  depends_on 'miniupnpc'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.patch
    # Fixes error when building .po files
    system "sed -i 's,GTK_DIR = gtk po,GTK_DIR = gtk,' Makefile.in"
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--enable-lightweight',
           '--enable-daemon',
           '--enable-cli',
           '--with-gtk'
    system 'make'
    system "echo '#!/bin/bash' > starttransmission"
    system "echo 'TRAN=\$(pidof transmission-daemon 2> /dev/null)' >> starttransmission"
    system "echo 'if [ -z \"\$TRAN\" ]; then' >> starttransmission"
    system "echo '  #{CREW_PREFIX}/bin/transmission-daemon -c ~/Downloads -w ~/Downloads &' >> starttransmission"
    system "echo '  sleep 3' >> starttransmission"
    system "echo 'fi' >> starttransmission"
    system "echo 'TRAN=\$(pidof transmission-daemon 2> /dev/null)' >> starttransmission"
    system "echo 'if [ ! -z \"\$TRAN\" ]; then' >> starttransmission"
    system "echo '  echo \"transmission process \$TRAN is running\"' >> starttransmission"
    system "echo 'else' >> starttransmission"
    system "echo '  echo \"transmission failed to start\"' >> starttransmission"
    system "echo '  exit 1' >> starttransmission"
    system "echo 'fi' >> starttransmission"
    system "echo '#!/bin/bash' > stoptransmission"
    system "echo 'TRAN=\$(pidof transmission-daemon 2> /dev/null)' >> stoptransmission"
    system "echo 'if [ ! -z \"\$TRAN\" ]; then' >> stoptransmission"
    system "echo '  sudo killall transmission-daemon' >> stoptransmission"
    system "echo '  sleep 3' >> stoptransmission"
    system "echo 'fi' >> stoptransmission"
    system "echo 'TRAN=\$(pidof transmission-daemon 2> /dev/null)' >> stoptransmission"
    system "echo 'if [ -z \"\$TRAN\" ]; then' >> stoptransmission"
    system "echo '  echo \"transmission process stopped\"' >> stoptransmission"
    system "echo 'else' >> stoptransmission"
    system "echo '  echo \"transmission process \$TRAN is running\"' >> stoptransmission"
    system "echo '  exit 1' >> stoptransmission"
    system "echo 'fi' >> stoptransmission"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "install -Dm755 starttransmission #{CREW_DEST_PREFIX}/bin/starttransmission"
    system "install -Dm755 stoptransmission #{CREW_DEST_PREFIX}/bin/stoptransmission"
  end

  def self.postinstall
    puts
    puts "To start the cli client, execute `transmission-cli`".lightblue
    puts
    puts "To start the gui client, execute `transmission-gtk`".lightblue
    puts
    puts "To start the daemon, execute `starttransmission`".lightblue
    puts
    puts "To stop the daemon, execute `stoptransmission`".lightblue
    puts
    puts "To start the daemon on login, execute the following:".lightblue
    puts "echo '# Start the transmission daemon' >> ~/.bashrc".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/bin/starttransmission ]; then' >> ~/.bashrc".lightblue
    puts "echo '  #{CREW_PREFIX}/bin/starttransmission' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
    puts "Configuration files are stored in `~/.config/transmission-daemon`".lightblue
    puts
  end
end
