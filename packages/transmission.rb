require 'package'

class Transmission < Package
  description 'A fast, easy, and free BitTorrent client.'
  homepage 'https://transmissionbt.com/'
  version '4.0.1'
  license 'GPL-2, GPL-3 or Transmission-OpenSSL-exception, GPL-2 and MIT'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/transmission/transmission/releases/download/4.0.1/transmission-4.0.1.tar.xz'
  source_sha256 '8fc5aef23638c983406f6a3ee9918369e4cdc84e3228bd2fb3d01dd55cdad900'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/transmission/4.0.1_armv7l/transmission-4.0.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/transmission/4.0.1_armv7l/transmission-4.0.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/transmission/4.0.1_x86_64/transmission-4.0.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a24a9d056da0fa9285b8e09c03176fbf7e088632075b7ac94211fb1aa56d825b',
     armv7l: 'a24a9d056da0fa9285b8e09c03176fbf7e088632075b7ac94211fb1aa56d825b',
     x86_64: 'e0892a64138e17054f34b4acdda32f37aee610eed50ad3a7f4da12d71b0bae46'
  })

  depends_on 'at_spi2_core'
  depends_on 'cairo'
  depends_on 'freetype' => :build
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'glibmm'
  depends_on 'gnome_icon_theme'
  depends_on 'gtk4'
  depends_on 'gtkmm4'
  depends_on 'harfbuzz'
  depends_on 'hicolor_icon_theme'
  depends_on 'libevent'
  depends_on 'libutp'
  depends_on 'miniupnpc'
  depends_on 'pango'
  depends_on 'shared_mime_info'
  depends_on 'vulkan_headers'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake \
        #{CREW_CMAKE_OPTIONS} \
        -DENABLE_CLI=ON \
        -DENABLE_GTK=ON \
        -DENABLE_UTILS=ON \
        -DINSTALL_LIB=ON \
        -DINSTALL_DOC=ON \
        -DUSE_GTK_VERSION=4 \
        .."
      system 'make'
    end
    starttransmission = <<~EOF
      #!/bin/bash
      TRAN=$(pidof transmission-daemon 2> /dev/null)
      if [ -z "$TRAN" ]; then
        #{CREW_PREFIX}/bin/transmission-daemon -c ~/Downloads -w ~/Downloads &
        sleep 3
      fi
      TRAN=$(pidof transmission-daemon 2> /dev/null)
      if [ -n "$TRAN" ]; then
        echo "transmission-daemon process $TRAN is running"
      else
        echo "transmission-daemon failed to start"
        exit 1
      fi
    EOF
    File.write('starttransmission', starttransmission)
    stoptransmission = <<~EOF
      #!/bin/bash
      TRAN=$(pidof transmission-daemon 2> /dev/null)
      if [ -n "$TRAN" ]; then
        sudo killall transmission-daemon
        sleep 3
      fi
      TRAN=$(pidof transmission-daemon 2> /dev/null)
      if [ -z "$TRAN" ]; then
        echo "transmission-daemon process stopped"
      else
        echo "transmission-daemon process $TRAN is running"
        exit 1
      fi
    EOF
    File.write('stoptransmission', stoptransmission)
    transmission = <<~EOF
      # Start the transmission daemon
      if [ -f #{CREW_PREFIX}/bin/starttransmission ]; then
        #{CREW_PREFIX}/bin/starttransmission
      fi
    EOF
    File.write('10-transmission', transmission)
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.install 'starttransmission', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install 'stoptransmission', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
    FileUtils.install '10-transmission', "#{CREW_DEST_PREFIX}/etc/bash.d", mode: 0o644
  end

  def self.postinstall
    puts "\nTo start the cli client, execute 'transmission-cli'".lightblue
    puts "\nTo start the gui client, execute 'transmission-gtk'".lightblue
    puts "\nTo start the daemon, execute 'starttransmission'".lightblue
    puts "\nTo stop the daemon, execute 'stoptransmission'".lightblue
    puts "\nTo finish the installation, execute 'source ~/.bashrc'".lightblue
    puts "\nConfiguration files are stored in #{HOME}/.config/transmission-daemon\n".lightblue
  end

  def self.preremove
    system 'stoptransmission'
  end

  def self.remove
    config_dirs_exist = false
    config_dirs = ["#{CREW_PREFIX}/.config/transmission", "#{CREW_PREFIX}/.config/transmission-daemon"]
    config_dirs.each do |config_dir|
      next unless Dir.exist? config_dir

      system "echo '#{config_dir}'; ls '#{config_dir}'"
      config_dirs_exist = true
    end
    if config_dirs_exist
      print "\nWould you like to remove the config directories above? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        config_dirs.each do |config_dir|
          FileUtils.rm_rf config_dir
          puts "#{config_dir} removed.".lightblue
        end
      else
        puts 'Directories saved.'.lightgreen
      end
    end
  end
end
