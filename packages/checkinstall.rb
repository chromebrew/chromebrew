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
    system 'wget', 'https://github.com/JL2210/patches/raw/267ebd80cc8d2c366cd3adb72e26d4cd51677571/checkinstall-1.6.2-chromebrew.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('checkinstall-1.6.2-chromebrew.patch') ) == '2a70ef396416c3a405b0c5dea54df867e52318efd9868fa1c0cf25c7d7b5e2f3'
    system 'patch -p1 < checkinstall-1.6.2-chromebrew.patch'
  end

  def self.build
    system 'make'
  end

  def self.install
    system "make", "install", "PREFIX=#{CREW_DEST_PREFIX}", "LCDIR=#{CREW_DEST_PREFIX}/etc/checkinstall", "CONFDIR=#{CREW_DEST_PREFIX}/share/checkinstall/locale", "LIBDIR=#{CREW_DEST_LIB_PREFIX}"
    system "sed -i 's,#{CREW_DEST_PREFIX},#{CREW_PREFIX},g' #{CREW_DEST_PREFIX}/bin/installwatch"
  end
end
