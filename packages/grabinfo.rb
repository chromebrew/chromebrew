require 'package'

class Grabinfo < Package
  description 'Navigates the /proc filesystem and executes commands in order to gather information about the state of your machine.'
  homepage 'https://sourceforge.net/projects/grabinfo/'
  version '1.71'
  source_url 'https://downloads.sourceforge.net/project/grabinfo/grabinfo/1.71/grabinfo-1.71.tar.gz'
  source_sha256 '3cf1e56aff10ef182065943a10ab815f2e8bf5ab77716dd97c2e91feb8db4278'

  depends_on 'perl'

  def self.build
    system "sed -i 's,/usr/bin,/usr/local/bin,g' grabinfo"
    system "sed -i 's,/var/log,/usr/local/share,g' grabinfo"
    system "sed -i 's,/var/log,/usr/local/share,g' grabinfo.1"
    system "sed -i 's,/usr/lib,/usr/local/lib,g' Makefile"
    system "sed -i 's,/usr/share,/usr/local/share,g' Makefile"
    system "sed -i 's,/var/log,/usr/local/share,g' Makefile"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/share/grabinfo"
    system "cp grabinfo #{CREW_DEST_DIR}/usr/local/bin"
    system "cp GrabInfo.pm #{CREW_DEST_DIR}/usr/local/bin"
    system "cp -r GrabInfo/ #{CREW_DEST_DIR}/usr/local/bin"
    system "cp grabinfo.1 #{CREW_DEST_DIR}/usr/local/man/man1"
  end
end
