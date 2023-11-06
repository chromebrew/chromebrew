require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  version '12.5.5'
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'
  source_url 'https://dist.torproject.org/torbrowser/12.5.5/tor-browser-linux64-12.5.5_ALL.tar.xz'
  source_sha256 '152d72c26fd42436624983dfd161e29285ffa3a58620ffa5410185783d20d9d7'

  depends_on 'gtk3'
  depends_on 'gdk_base'

  no_compile_needed
  no_shrink

  def self.build
    tor = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/torbrowser
      ./start-tor-browser.desktop "$@"
    EOF
    File.write('tor', tor)
  end

  def self.patch
    system "sed -i 's,$(pwd),#{CREW_PREFIX}/share/torbrowser,g' start-tor-browser.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/torbrowser"
    FileUtils.mv 'Browser/', "#{CREW_DEST_PREFIX}/share/torbrowser"
    FileUtils.mv 'start-tor-browser.desktop', "#{CREW_DEST_PREFIX}/share/torbrowser"
    FileUtils.install 'tor', "#{CREW_DEST_PREFIX}/bin/tor", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nTo finish the installation, please execute the following:\nsource ~/.bashrc".lightblue, print_last: true
    print "\nSet Tor as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'tor', 'x-www-browser'
      end
      puts 'Tor is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    puts "\nType 'tor' to get started.\n".lightblue
  end

  def self.remove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') \
        && (File.realpath('x-www-browser') == "#{CREW_PREFIX}/bin/tor")
        FileUtils.rm 'x-www-browser'
      end
    end
    config_dir = "#{CREW_PREFIX}/share/torbrowser"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
