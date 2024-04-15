require 'package'

class Torbrowser < Package
  description "'The Onion Router' browser"
  homepage 'https://www.torproject.org/'
  version '13.0.13'
  license 'BSD, custom, MPL-2.0 and MIT'
  compatibility 'x86_64'
  source_url 'https://dist.torproject.org/torbrowser/13.0.13/tor-browser-linux-x86_64-13.0.13.tar.xz'
  source_sha256 '97b29af2f8d55faed93cfcd19d08b1b648b9fdc6213fa3ff27dd42c863e7c1f2'

  depends_on 'gtk3'
  depends_on 'gdk_base'

  no_compile_needed
  no_shrink
  print_source_bashrc

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
