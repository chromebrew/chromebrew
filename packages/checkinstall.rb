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
    system 'wget', 'https://github.com/JL2210/patches/raw/1e6cdac481ead1382bc9e10366004119bb362128/checkinstall-1.6.2-chromebrew.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('checkinstall-1.6.2-chromebrew.patch') ) == '10ac25d4aa32005492cec94385caaf92fbb4ee0e108577ed472a526b11ce0624'
    system 'patch -Np1 -i checkinstall-1.6.2-chromebrew.patch'
  end

  def self.build
    system 'make'
  end

  def self.install
    system "make",
           "install",
           "PREFIX=#{CREW_DEST_PREFIX}",
           "LCDIR=#{CREW_DEST_PREFIX}/share/checkinstall/locale",
           "CONFDIR=#{CREW_DEST_PREFIX}/etc/checkinstall",
           "LIBDIR=#{CREW_DEST_LIB_PREFIX}"
    system "sed -i 's,#{CREW_DEST_PREFIX},#{CREW_PREFIX},g' #{CREW_DEST_PREFIX}/bin/installwatch"
  end
end
