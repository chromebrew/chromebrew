require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.2.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-1.1.1.tar.gz'
  source_sha256 'a26699704bb4ddf2684e4adc1f46d5f3de9a9a8959f147970f969cc32b2f0d9e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afed9916e17bb13666ef97098d3128cbb535e33593814ed50e1b844cae2a054f',
     armv7l: 'afed9916e17bb13666ef97098d3128cbb535e33593814ed50e1b844cae2a054f',
       i686: '888742d0f5dcdb5a7b226c46f38148a66916bf5c59d9cfa893874de7e97033f4',
     x86_64: '5bb56619e8579ec7c9f038fa39ce76f9b741652a4dbf54654c611c1f82152aee'
  })

  depends_on 'rust' => :build
  depends_on 'libcheck' => :build
  depends_on 'libiconv' => :build
  depends_on 'jsonc' => :build
  depends_on 'py3_pytest' => :build

  def self.build
    system "cmake #{CREW_CMAKE_OPTIONS} -B build \
            -D APP_CONFIG_DIRECTORY=#{CREW_PREFIX}/etc/clamav \
            -D DATABASE_DIRECTORY=#{CREW_PREFIX}/share/clamav \
            -D CMAKE_C_FLAGS=-fPIC \
            -D ENABLE_JSON_SHARED=OFF \
            -D ENABLE_STATIC_LIB=ON \
            -D ENABLE_SYSTEMD=OFF \
            -D ENABLE_MILTER=OFF \
            -G Ninja"
    system "#{CREW_NINJA} -C build"
  end

  def self.check
    system 'ctest -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C build install"
    FileUtils.cp "#{CREW_DEST_PREFIX}/etc/clamav/clamd.conf.sample", "#{CREW_DEST_PREFIX}/etc/clamav/clamd.conf"
    FileUtils.cp "#{CREW_DEST_PREFIX}/etc/clamav/freshclam.conf.sample", "#{CREW_DEST_PREFIX}/etc/clamav/freshclam.conf"
    system "sed -i 's,^Example,#Example,' #{CREW_DEST_PREFIX}/etc/clamav/clamd.conf"
    system "sed -i 's,^#LocalSocket ,LocalSocket ,' #{CREW_DEST_PREFIX}/etc/clamav/clamd.conf"
    system "sed -i 's,^Example,#Example,' #{CREW_DEST_PREFIX}/etc/clamav/freshclam.conf"
  end

  def self.postinstall
    system 'freshclam' # Create the clamav database.
    puts "\nTo start the clamav daemon, execute the following:".lightblue
    puts 'sudo clamd &'.lightblue
    puts "\nTo modify the clamav config, edit the following:".lightblue
    puts "#{CREW_PREFIX}/etc/clamav/clamd.conf".lightblue
    puts "#{CREW_PREFIX}/etc/clamav/freshclam.conf\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/share/clamav"
    if Dir.exist? config_dir
      puts 'WARNING: This will remove the clamav database!'.orange
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
