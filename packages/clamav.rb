require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.3.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-1.3.1.tar.gz'
  source_sha256 '12a3035bf26f55f71e3106a51a5fa8d7b744572df98a63920a9cff876a7dcce4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'caab8a0c813eceb49dd3d531c8ac6c03c8c475791604347d067218b74bb202a9',
     armv7l: 'caab8a0c813eceb49dd3d531c8ac6c03c8c475791604347d067218b74bb202a9',
       i686: 'f8f4a7a89e2b427aff44587bebe0834ee3dbdd95f7f2e89627d739a386498c0a',
     x86_64: '3149f0230e8ee22842eda13bd168f070ad44daf2cc19ecf5dbdbcb509434739a'
  })

  depends_on 'rust' => :build
  depends_on 'libcheck' => :build
  depends_on 'libiconv' => :build
  depends_on 'json_c' => :build
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
