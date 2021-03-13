require 'package'

class Phpsysinfo < Package
  description 'phpSysInfo is a customizable PHP Script that parses /proc, and formats information nicely.'
  homepage 'https://phpsysinfo.github.io/phpsysinfo/'
  version '3.3.3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/phpsysinfo/phpsysinfo/3.3.3/phpsysinfo-3.3.3.tar.gz'
  source_sha256 '08f083b73cdb35a17449a4d771b65b8439b05ab5f4982782a53275d345dea30f'

  depends_on 'php74' unless File.exists? "#{CREW_PREFIX}/bin/php"

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpsysinfo"
    FileUtils.cp 'phpsysinfo.ini.new', 'phpsysinfo.ini'
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/phpsysinfo/"
  end

  def self.postinstall
    puts "\nTo get started, execute the following:".lightblue
    puts "cd #{CREW_PREFIX}/share/phpsysinfo".lightblue
    puts "php -S localhost:9000".lightblue
    puts "Visit localhost:9000 in your browser.\n".lightblue
  end
end
