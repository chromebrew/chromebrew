require 'package'

class Acpi < Package
  description 'Attempts to replicate the functionality of the \'old\' apm command on ACPI systems, including battery and thermal information.'
  homepage 'https://sourceforge.net/projects/acpiclient/'
  version '1.7'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/acpiclient/acpiclient/1.7/acpi-1.7.tar.gz'
  source_sha256 'd7a504b61c716ae5b7e81a0c67a50a51f06c7326f197b66a4b823de076a35005'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/acpi-1.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/acpi-1.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/acpi-1.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/acpi-1.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '86f608f45ef9c7d423f26f4b1a268e7b995061e1ecb613bf3fbca2d9c7bf5665',
     armv7l: '86f608f45ef9c7d423f26f4b1a268e7b995061e1ecb613bf3fbca2d9c7bf5665',
       i686: 'bbb6d7c0db9e4777aaca3b38e08affc74f16af661274b2d962ef8189a5338d2f',
     x86_64: 'db69280f951b024431221a7f28af55b9f103baa82a981619a3da01c161c2d485',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
