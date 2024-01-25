require 'package'

class Stellarium < Package
  description 'Stellarium is a free open source planetarium for your computer.'
  homepage 'http://stellarium.org/'
  version '0.21.1'
  license 'GPL-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/Stellarium/stellarium/releases/download/v0.21.1/stellarium-0.21.1.tar.gz'
  source_sha256 '072309c6bc48233b39884ae558b23764d0e08eabd96b014b53d780be11a33211'
  binary_compression 'tar.xz'

  binary_sha256({
    x86_64: '4618a03c3b1b70a05b4aef9e0aa120b1fb49e8ac5b6511de90e207b6b3cb99e2'
  })

  depends_on 'qtlocation'
  depends_on 'qtmultimedia'
  depends_on 'qtscript'
  depends_on 'qtserialport'
  depends_on 'qttools'
  depends_on 'qtwayland'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake #{CREW_CMAKE_OPTIONS} -DENABLE_GPS=0 .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.postinstall
    puts "\nType 'stellarium' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{HOME}/.stellarium"
    if Dir.exist? config_dir
      print "Would you like to remove the config directory #{config_dir}? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightred
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
