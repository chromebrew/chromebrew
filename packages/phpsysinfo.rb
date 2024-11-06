require 'package'

class Phpsysinfo < Package
  description 'phpSysInfo is a customizable PHP Script that parses /proc, and formats information nicely.'
  homepage 'https://phpsysinfo.github.io/phpsysinfo/'
  version '3.4.1'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/phpsysinfo/phpsysinfo/archive/v3.4.1.tar.gz'
  source_sha256 '377bafea4dc4f1f705cd35df5b95e55034045ab3e7971dc934d1f599157dc3aa'

  depends_on 'php74' unless File.exist? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpsysinfo"
    FileUtils.cp 'phpsysinfo.ini.new', 'phpsysinfo.ini'
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/phpsysinfo/"
  end

  def self.postinstall
    puts "\nTo get started, execute the following:".lightblue
    puts "cd #{CREW_PREFIX}/share/phpsysinfo".lightblue
    puts 'php -S localhost:9000'.lightblue
    puts "Visit localhost:9000 in your browser.\n".lightblue
  end
end
