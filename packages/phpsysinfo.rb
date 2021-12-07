require 'package'

class Phpsysinfo < Package
  description 'phpSysInfo is a customizable PHP Script that parses /proc, and formats information nicely.'
  homepage 'https://phpsysinfo.github.io/phpsysinfo/'
  version '3.3.4'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/phpsysinfo/phpsysinfo/archive/v3.3.4.tar.gz'
  source_sha256 '5a0c880519df3c61b1c97c7bbb8c349dc2dde4f25e506478a0a643e47d25ff5e'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpsysinfo"
    FileUtils.cp 'phpsysinfo.ini.new', 'phpsysinfo.ini'
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/phpsysinfo/"
  end

  def self.postinstall
    puts "\nTo get started, execute the following:".lightblue
    puts "cd #{CREW_PREFIX}/share/phpsysinfo".lightblue
    puts "php -S localhost:9000".lightblue
    puts "Visit localhost:9000 in your browser.\n".lightblue
  end
end
