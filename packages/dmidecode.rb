require 'package'

class Dmidecode < Package
  description "Dmidecode reports information about your system's hardware as described in your system BIOS according to the SMBIOS/DMI standard (see a sample output)."
  homepage 'http://www.nongnu.org/dmidecode/'
  version '3.1'
  source_url 'http://download.savannah.gnu.org/releases/dmidecode/dmidecode-3.1.tar.xz'
  source_sha256 'd766ce9b25548c59b1e7e930505b4cad9a7bb0b904a1a391fbb604d529781ac0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dmidecode-3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a3f1bf96a328ee441940346e0a907ad26e3656676eb3750d00b749fac0912bbe',
     armv7l: 'a3f1bf96a328ee441940346e0a907ad26e3656676eb3750d00b749fac0912bbe',
       i686: '2d5cd5a5d2bc1a91a1b83ef7fb5c3d1054ff07d8ba7b6f73a7944aa8e83e38f2',
     x86_64: 'ee453a6dada1736e1c9ac271d2b540bbdc1b7682e8db637b0dcf381e9e4fc5d1',
  })

  def self.build
    case ARCH
    when 'i686', 'x86_64'
      system 'make'
    else
      puts "#{ARCH} architecture not supported.".lightred
    end
  end

  def self.install
    case ARCH
    when 'i686', 'x86_64'
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      puts ""
      puts "To complete the installation, execute the following:".lightblue
      puts "echo 'export PATH=$PATH:/usr/local/sbin' >> ~/.bashrc && source ~/.bashrc".lightblue
      puts ""
    end
  end
end
