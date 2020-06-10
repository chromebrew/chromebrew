require 'package'

class Disktype < Package
  description 'Detects the content format of a disk or disk image by checking for signatures of file systems, partition tables, and boot codes.'
  homepage 'https://sourceforge.net/projects/disktype/'
  version '9'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/disktype/disktype/9/disktype-9.tar.gz'
  source_sha256 'b6701254d88412bc5d2db869037745f65f94b900b59184157d072f35832c1111'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/disktype-9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/disktype-9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/disktype-9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/disktype-9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dad43a9f53a1e1678c9279ee0190df4b97304f313874d1684820baaec1594852',
     armv7l: 'dad43a9f53a1e1678c9279ee0190df4b97304f313874d1684820baaec1594852',
       i686: '4f7db66b89b225c401222f728e99d0bd61935f2da271999333ac5e8fb2e09477',
     x86_64: '807040a6c0d90a8dd4640b008bb0331402b1c232e243a8a14f1ab236933d60ac',
  })

  def self.build
    system "make"
  end

  def self.install
    system "install -Dm755 disktype #{CREW_DEST_PREFIX}/bin/disktype"
    system "install -Dm644 disktype.1 #{CREW_DEST_PREFIX}/share/man/man1/disktype.1"
  end
end
