require 'package'

class Lsb_release < Package
  description 'Linux Standard Base'
  homepage 'https://wiki.linuxfoundation.org/lsb/start'
  version '1.4-3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/lsb/lsb_release/1.4/lsb-release-1.4.tar.gz'
  source_sha256 '99321288f8d62e7a1d485b7c6bdccf06766fb8ca603c6195806e4457fdf17172'

  binary_sha256({})

  depends_on 'help2man'
  depends_on 'make'

  def self.build
    system 'cp /etc/lsb-release /tmp'
    system 'STR=$(grep ^CHROMEOS_RELEASE_NAME= /tmp/lsb-release | cut -d= -f2) && sed -i "s,$STR,\'&\'," /tmp/lsb-release'
    system 'STR=$(grep ^CHROMEOS_RELEASE_BUILD_TYPE= /tmp/lsb-release | cut -d= -f2) && sed -i "s,$STR$,\'&\'," /tmp/lsb-release'
    system 'STR=$(grep ^CHROMEOS_RELEASE_DESCRIPTION= /tmp/lsb-release | cut -d= -f2) && sed -i "s,$STR,\'&\'," /tmp/lsb-release'
    system "sed -i 's,INFO_ROOT=\"/etc\",INFO_ROOT=\"#{CREW_PREFIX}/etc\",' lsb_release"
    system "sed -i 's,LSB_VERSION=\$MSG_NA,LSB_VERSION=1.4,' lsb_release"
    system "sed -i 's,DISTRIB_ID,CHROMEOS_RELEASE_NAME,g' lsb_release"
    system "sed -i 's,DISTRIB_DESCRIPTION,CHROMEOS_RELEASE_DESCRIPTION,g' lsb_release"
    system "sed -i 's,DISTRIB_RELEASE,CHROMEOS_RELEASE_CHROME_MILESTONE,g' lsb_release"
    system "sed -i 's,DISTRIB_CODENAME,CHROMEOS_RELEASE_BOARD,g' lsb_release"
    system "sed -i 's,echo -e,echo,g' lsb_release"
    system "sed -i 's,--include,-i,' Makefile"
    system "sed -i 's,./help2man,help2man,' Makefile"
    system "sed -i 's,--alt_version_key=program_version ,,' Makefile"
    system 'make'
  end

  def self.install
    FileUtils.install 'lsb_release', "#{CREW_DEST_PREFIX}/bin/lsb_release", mode: 0o755
    FileUtils.install '/tmp/lsb-release', "#{CREW_DEST_PREFIX}/etc/lsb-release", mode: 0o644
    FileUtils.install 'lsb_release.1.gz', "#{CREW_DEST_MAN_PREFIX}/man1/lsb_release.1.gz", mode: 0o644
  end
end
