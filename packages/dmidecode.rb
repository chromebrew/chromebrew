require 'package'

class Dmidecode < Package
  description "Dmidecode reports information about your system's hardware as described in your system BIOS according to the SMBIOS/DMI standard (see a sample output)."
  homepage 'http://www.nongnu.org/dmidecode/'
  version '3.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/dmidecode/dmidecode-3.5.tar.xz'
  source_sha256 '79d76735ee8e25196e2a722964cf9683f5a09581503537884b256b01389cc073'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dmidecode/3.5_armv7l/dmidecode-3.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dmidecode/3.5_armv7l/dmidecode-3.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dmidecode/3.5_i686/dmidecode-3.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/dmidecode/3.5_x86_64/dmidecode-3.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cb38d8205474b2780871da16f96f109c77cde0c804f244597b4211ecb50a1c17',
     armv7l: 'cb38d8205474b2780871da16f96f109c77cde0c804f244597b4211ecb50a1c17',
       i686: 'be0f1f35877a1de79af3eae6604923de5bf9dbfbda28c1482bf5fae59fcfc05b',
     x86_64: 'c8202d5a2bea79d0791074759736278a5755405ccdc7107e3bee654450ad7ddc'
  })

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
