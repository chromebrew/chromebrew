require 'package'

class Swatchdog < Package
  description 'The "simple watchdog" for activity monitoring log files produced by UNIX\'s syslog facility.'
  homepage 'http://swatch.sourceforge.net/'
  version '3.2.4-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/swatch/swatchdog/swatchdog-3.2.4.tar.gz'
  source_sha256 '5bb644d3750ee89b9aecab797df66b28b9fd174a5f0f96cd62367af8975b4f63'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/swatchdog-3.2.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '731c2d136119b6be6ddf66ffea0fbddc653f80cc9ad3a8ed5d51bee7cbf43fec',
     armv7l: '731c2d136119b6be6ddf66ffea0fbddc653f80cc9ad3a8ed5d51bee7cbf43fec',
       i686: '68806febf6e69df75274f48e9c88eb0a0025b6a76f2961f0d2b0564bee0c5780',
     x86_64: '58d94d0e0043a1f234ecf67592cf056115cd5f69afdae83affba5078ad6445c1',
  })

  depends_on 'perl_carp_clan'
  depends_on 'perl_date_calc'
  depends_on 'perl_date_format'
  depends_on 'perl_date_manip'
  depends_on 'perl_file_tail'

  def self.build
    system 'perl', 'Makefile.PL'
    system 'make'
  end

  def self.check
    system 'make', 'test'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p CREW_DEST_HOME
    system "cat << 'EOF' > #{CREW_DEST_HOME}/.swatchdogrc
watchfor /err/i
    echo red
EOF"
  end

  def self.postinstall
    puts
    puts "Example: swatchdog -t /var/log/messages".lightblue
    puts
  end
end
