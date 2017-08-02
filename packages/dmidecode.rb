require 'package'

class Dmidecode < Package
  description "Dmidecode reports information about your system's hardware as described in your system BIOS according to the SMBIOS/DMI standard (see a sample output)."
  homepage 'http://www.nongnu.org/dmidecode/'
  version '3.1'
  source_url 'http://download.savannah.gnu.org/releases/dmidecode/dmidecode-3.1.tar.xz'
  source_sha256 'd766ce9b25548c59b1e7e930505b4cad9a7bb0b904a1a391fbb604d529781ac0'

  def self.build
    case ARCH
    when 'aarch64', 'armv7l'
      abort "#{ARCH} architecture not supported.".lightred
    end
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    puts ""
    puts "To complete the installation, execute the following:".lightblue
    puts "echo 'export PATH=$PATH:/usr/local/sbin' >> ~/.bashrc && source ~/.bashrc".lightblue
    puts ""
  end
end
