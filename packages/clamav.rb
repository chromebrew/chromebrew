require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.3.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-1.3.0.tar.gz'
  source_sha256 '0a86a6496320d91576037b33101119af6fd8d5b91060cd316a3a9c229e9604aa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c56f67bd30b297677b3d264fc8c51bc657f9e420ee8db3044f447407ad1166b3',
     armv7l: 'c56f67bd30b297677b3d264fc8c51bc657f9e420ee8db3044f447407ad1166b3',
       i686: '7ecc0239e776f9388644ce393762f1dea2e01f6644f6131bfebaebfbfffd9416',
     x86_64: '9fafa4301f43066ba35a6dcb2033b1c7898afbeb40348c6fd078df190c698ea7'
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
