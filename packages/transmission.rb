require 'package'

class Transmission < Package
  description 'A fast, easy, and free BitTorrent client.'
  homepage 'https://transmissionbt.com/'
  version '4.0.5'
  license 'GPL-2, GPL-3 or Transmission-OpenSSL-exception, GPL-2 and MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/transmission/transmission/releases/download/4.0.5/transmission-4.0.5.tar.xz'
  source_sha256 'fd68ff114a479200043c30c7e69dba4c1932f7af36ca4c5b5d2edcb5866e6357'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '50ece0c1242810e225e81ba3d25191d139fa4870271b6cb6b9030e0d58033bbd',
     armv7l: '50ece0c1242810e225e81ba3d25191d139fa4870271b6cb6b9030e0d58033bbd',
     x86_64: 'f61812f7df704895bf13b4b405afb155af5da0b2351e5ef84657b04422b7666e'
  })

  depends_on 'at_spi2_core' => :build
  depends_on 'cairomm_1_16' # R
  depends_on 'cairo' # R
  depends_on 'curl' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'gnome_icon_theme' # L
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'gtkmm4' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # L
  depends_on 'libdeflate' # R
  depends_on 'libevent' # R
  depends_on 'libpsl' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'libutp' # L
  depends_on 'miniupnpc' # R
  depends_on 'openssl' # R
  depends_on 'pangomm_2_48' # R
  depends_on 'pango' # R
  depends_on 'shared_mime_info'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'xdg_base' # L

  def self.build
    system "cmake -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DENABLE_CLI=ON \
      -DENABLE_GTK=ON \
      -DENABLE_UTILS=ON \
      -DINSTALL_LIB=ON \
      -DINSTALL_DOC=ON \
      -DUSE_GTK_VERSION=4"
    system "#{CREW_NINJA} -C builddir"
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
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
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
