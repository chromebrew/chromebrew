require 'package'

class Dmidecode < Package
  description "Dmidecode reports information about your system's hardware as described in your system BIOS according to the SMBIOS/DMI standard (see a sample output)."
  homepage 'http://www.nongnu.org/dmidecode/'
  version '3.7'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://download.savannah.gnu.org/releases/dmidecode/dmidecode-#{version}.tar.xz"
  source_sha256 '2c3aed12c85a1e6a9410d406d5e417c455466dc1bc7c89278bb32cf7cad91e8a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1d9708685a0e268ffdb4497d60380d18d7ee8ed3b1db5cced8fa25c9a8f80f0e',
     armv7l: '1d9708685a0e268ffdb4497d60380d18d7ee8ed3b1db5cced8fa25c9a8f80f0e',
       i686: '92bd14db29954c7edc1c2e1d287d4f56ddf2bd587c89bbfae9d7d11e64749c0a',
     x86_64: '4adf7327a0dae8dde677da66ee3b346eb4a9ed3e5e9f835fa41d03d8e3fe3658'
  })

  depends_on 'glibc' => :executable

  def self.patch
    system "sed -i 's,^prefix = /usr/local,prefix = #{CREW_PREFIX},' Makefile"
    case ARCH
    when 'aarch64', 'armv7l'
      system "sed -i '55iPROGRAMS-#{ARCH} := biosdecode ownership vpddecode' Makefile"
      system "sed -i 's,#CFLAGS += -DBIGENDIAN,CFLAGS += -DBIGENDIAN,' Makefile"
      system "sed -i 's,#CFLAGS += -DALIGNMENT_WORKAROUND,CFLAGS += -DALIGNMENT_WORKAROUND,' Makefile"
    end
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts "\nTo report information about the system hardware, execute the following:".lightblue
    puts "sudo dmidecode\n".lightblue
  end
end
