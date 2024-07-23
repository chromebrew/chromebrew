require 'package'

class Snowflake < Package
  description 'Snowflake (aka Muon) is a graphical SSH client.'
  homepage 'https://github.com/subhra74/snowflake'
  version '1.0.4'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'SKIP'
  binary_compression 'tpxz'

  binary_sha256({
    x86_64: '4e524ad28ef440ded64cb667b188ced01d662fc8240d85be39cc7319a306e99f'
  })

  depends_on 'jdk11'
  depends_on 'sommelier'

  def self.build
    snowflake = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/snowflake
      java -jar snowflake.jar "$@"
    EOF
    File.write('snowflake.sh', snowflake)
  end

  def self.install
    system "curl -L#o snowflake.jar https://github.com/subhra74/snowflake/releases/download/v#{version}/snowflake.jar"
    abort 'Checksum mismatch. 😔 Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('snowflake.jar')) == 'cc1768e5ce7038d26a893e00066e4d8bed2f42c1ba75b960b324471c5eab74c1'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/snowflake"
    FileUtils.mv 'snowflake.jar', "#{CREW_DEST_PREFIX}/share/snowflake"
    FileUtils.install 'snowflake.sh', "#{CREW_DEST_PREFIX}/bin/snowflake", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'snowflake' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/snowflake-ssh"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove all saved ssh sessions!'.orange
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
