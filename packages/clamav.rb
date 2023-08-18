require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '1.1.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-1.1.1.tar.gz'
  source_sha256 'a26699704bb4ddf2684e4adc1f46d5f3de9a9a8959f147970f969cc32b2f0d9e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/1.1.1_armv7l/clamav-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/1.1.1_armv7l/clamav-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/1.1.1_i686/clamav-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/1.1.1_x86_64/clamav-1.1.1-chromeos-x86_64.tar.zst',
  })
  binary_sha256({
    aarch64: '99ec7eed070ac95692e6dd79b3db5e5e5d81bb2d2895847e0a4e3a574d11c00f',
     armv7l: '99ec7eed070ac95692e6dd79b3db5e5e5d81bb2d2895847e0a4e3a574d11c00f',
       i686: 'a8a01408181b94d88bc3f9eb404b7b8373db229251048af6d52e1c001f22a5b2',
     x86_64: '55a9893ae7c4fd3416c3a119c0928d0ac88bf245cdf1bf1bb1c1657b3aa1c5b0',
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
