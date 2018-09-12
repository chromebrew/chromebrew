require 'package'

class Checkinstall < Package
  description 'CheckInstall is a computer program for Unix-like operating systems which eases the installation and uninstallation of software compiled from source by making use of package management systems.'
  homepage 'http://asic-linux.com.mx/~izto/checkinstall/'
  version '1.6.2'
  source_url 'http://asic-linux.com.mx/~izto/checkinstall/files/source/checkinstall-1.6.2.tar.gz'
  source_sha256 'dc61192cf7b8286d42c44abae6cf594ee52eafc08bfad0bea9d434b73dd593f4'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.patch
    system 'wget', 'https://github.com/JL2210/patches/raw/da54bdfb4aea5dfbab8c08224ebd9416fc2bc62d/checkinstall.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('checkinstall.patch') ) == '71c36071df8deaf3c14caa58d79fd86eb9262872281226c2ee0e48b640c182ce'
    system 'patch -p1 < checkinstall.patch'
  end

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/"
    system "make", "install", "PREFIX=#{CREW_PREFIX}", "LCDIR=#{CREW_LIB_PREFIX}/checkinstall", "CONFDIR=#{CREW_LIB_PREFIX}/checkinstall/locale", "LIBDIR=#{CREW_LIB_PREFIX}"
    system "cp -pa #{CREW_PREFIX}/bin/installwatch #{CREW_DEST_PREFIX}/bin/"
    system "cp -rpa #{CREW_LIB_PREFIX}/checkinstall/ #{CREW_DEST_LIB_PREFIX}/"
    system "cp -pa #{CREW_LIB_PREFIX}/installwatch.so #{CREW_DEST_LIB_PREFIX}/"
    system "cp -pa #{CREW_PREFIX}/sbin/checkinstall #{CREW_DEST_PREFIX}/bin/"
    system "cp -pa #{CREW_PREFIX}/sbin/makepak #{CREW_DEST_PREFIX}/bin/"
  end
end
