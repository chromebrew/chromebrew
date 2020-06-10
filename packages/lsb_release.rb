require 'package'

class Lsb_release < Package
  description 'Linux Standard Base'
  homepage 'https://wiki.linuxfoundation.org/lsb/start'
  version '1.4-1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/lsb/lsb_release/1.4/lsb-release-1.4.tar.gz'
  source_sha256 '99321288f8d62e7a1d485b7c6bdccf06766fb8ca603c6195806e4457fdf17172'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'help2man'

  def self.build
    system "cp /etc/lsb-release /tmp"
    system 'STR=$(grep ^CHROMEOS_RELEASE_NAME= /tmp/lsb-release | cut -d= -f2) && sed -i "s,$STR,\'&\'," /tmp/lsb-release'
    system 'STR=$(grep ^CHROMEOS_RELEASE_BUILD_TYPE= /tmp/lsb-release | cut -d= -f2) && sed -i "s,$STR$,\'&\'," /tmp/lsb-release'
    system 'STR=$(grep ^CHROMEOS_RELEASE_DESCRIPTION= /tmp/lsb-release | cut -d= -f2) && sed -i "s,$STR,\'&\'," /tmp/lsb-release'
    system "sed -i 's,INFO_ROOT=\"/etc\",INFO_ROOT=\"#{CREW_PREFIX}/etc\",' lsb_release"
    system "sed -i 's,LSB_VERSION=\$MSG_NA,LSB_VERSION=1.4,' lsb_release"
    system "sed -i 's,DISTRIB_ID,CHROMEOS_RELEASE_NAME,g' lsb_release"
    system "sed -i 's,DISTRIB_DESCRIPTION,CHROMEOS_RELEASE_DESCRIPTION,g' lsb_release"
    system "sed -i 's,DISTRIB_RELEASE,CHROMEOS_RELEASE_VERSION,g' lsb_release"
    system "sed -i 's,DISTRIB_CODENAME,CHROMEOS_RELEASE_BOARD,g' lsb_release"
    system "sed -i 's,echo -e,echo,g' lsb_release"
    system "sed -i 's,--include,-i,' Makefile"
    system "sed -i 's,./help2man,help2man,' Makefile"
    system "sed -i 's,--alt_version_key=program_version ,,' Makefile"
    system 'make'
  end

  def self.install
    system "install -Dm755 lsb_release #{CREW_DEST_PREFIX}/bin/lsb_release"
    system "install -Dm644 /tmp/lsb-release #{CREW_DEST_PREFIX}/etc/lsb-release"
    system "install -Dm644 lsb_release.1.gz #{CREW_DEST_PREFIX}/man/man1/lsb_release.1.gz"
  end
end
