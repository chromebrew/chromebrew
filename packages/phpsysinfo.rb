require 'package'

class Phpsysinfo < Package
  description 'phpSysInfo is a customizable PHP Script that parses /proc, and formats information nicely.'
  homepage 'https://phpsysinfo.github.io/phpsysinfo/'
  version '3.4.6'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/phpsysinfo/phpsysinfo.git'
  git_hashtag "v#{version}"

  depends_on 'php84' unless File.exist? "#{CREW_PREFIX}/bin/php"

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/phpsysinfo"
    FileUtils.cp 'phpsysinfo.ini.new', 'phpsysinfo.ini'
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/phpsysinfo/"
  end

  def self.postinstall
    ExitMessage.add <<~EOM
      To get started, execute the following:
      cd #{CREW_PREFIX}/share/phpsysinfo
      php -S localhost:9000
      Visit http://localhost:9000 in your browser.
    EOM
  end
end
