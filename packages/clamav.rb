require 'package'

class Clamav < Package
  description 'ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.'
  homepage 'https://www.clamav.net/'
  version '0.105.1-3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.clamav.net/downloads/production/clamav-0.105.1-3.tar.gz'
  source_sha256 '86d832917185c3512e639297e3d727be6b64a56e32a33b3a1522b98d7c725075'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/0.105.1-3_armv7l/clamav-0.105.1-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/0.105.1-3_armv7l/clamav-0.105.1-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/0.105.1-3_i686/clamav-0.105.1-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/clamav/0.105.1-3_x86_64/clamav-0.105.1-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '479adab2c53567e4124b85433ff5ad84e001595dd3f01104a337695b7a8b9a3a',
     armv7l: '479adab2c53567e4124b85433ff5ad84e001595dd3f01104a337695b7a8b9a3a',
       i686: '13ce7a928a24c35b0aafc8bdc3650c24a22e570f02844af07cb0bdfb5e65cdf4',
     x86_64: 'e7be225a7ad29a203d6a4cd644573c1b92f5930509ba478b70c23598ebbaa414'
  })

  depends_on 'rust' => :build
  depends_on 'libcheck' => :build
  depends_on 'libiconv' => :build
  depends_on 'jsonc' => :build
  depends_on 'py3_pytest' => :build

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. #{CREW_CMAKE_OPTIONS} \
              -D APP_CONFIG_DIRECTORY=#{CREW_PREFIX}/etc/clamav \
              -D DATABASE_DIRECTORY=#{CREW_PREFIX}/share/clamav \
              -D CMAKE_C_FLAGS=-fPIC \
              -D ENABLE_JSON_SHARED=OFF \
              -D ENABLE_STATIC_LIB=ON \
              -D ENABLE_SYSTEMD=OFF \
              -D ENABLE_MILTER=OFF \
              -G Ninja"
    end
    system 'samu -C build'
  end

  def self.check
    system 'ctest -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C build install"
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
      case $stdin.getc
      when 'y', 'Y'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
