require 'package'

class Disktype < Package
  description 'Detects the content format of a disk or disk image by checking for signatures of file systems, partition tables, and boot codes.'
  homepage 'https://sourceforge.net/projects/disktype/'
  version '9'
  source_url 'http://downloads.sourceforge.net/project/disktype/disktype/9/disktype-9.tar.gz'
  source_sha256 'b6701254d88412bc5d2db869037745f65f94b900b59184157d072f35832c1111'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make"
  end

  def self.install
    system "install -Dm755 disktype #{CREW_DEST_PREFIX}/bin/disktype"
    system "install -Dm644 disktype.1 #{CREW_DEST_PREFIX}/share/man/man1/disktype.1"
  end
end
