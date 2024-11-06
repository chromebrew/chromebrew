require 'package'

class Metasploit < Package
  description 'The Metasploit Framework is a tool for developing and executing exploit code against a remote target machine.'
  homepage 'https://www.metasploit.com/'
  version '6.4.15'
  license 'BSD-3'
  compatibility 'all'
  source_url "https://github.com/rapid7/metasploit-framework/archive/#{version}.tar.gz"
  source_sha256 'f0385cc05dcf2b0d8aef0c4609acde7396aa91650ca34d452a7a60be13f04732'

  no_compile_needed

  depends_on 'ruby'
  depends_on 'readline'
  depends_on 'openssl'
  depends_on 'libpcap'
  depends_on 'postgresql'
  depends_on 'sqlite'
  depends_on 'libxslt'
  depends_on 'libxml2'
  depends_on 'bison'

  def self.build
    system 'gem install bundler --conservative'
    system 'NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/metasploit-framework"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/metasploit-framework"
    %w[msfconsole msfd msfrpc msfrpcd msfupdate msfvenom].each do |bin|
      FileUtils.ln_s "#{CREW_PREFIX}/share/metasploit-framework/#{bin}", "#{CREW_DEST_PREFIX}/bin/#{bin}"
    end
  end

  def self.postremove
    config_dir = "#{HOME}/.msf4"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
