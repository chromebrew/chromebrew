require 'package'

class Libavc1394 < Package
  description 'libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set.'
  homepage 'https://sourceforge.net/projects/libavc1394/'
  version '0.5.4-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libavc1394/libavc1394/libavc1394-0.5.4.tar.gz'
  source_sha256 '7cb1ff09506ae911ca9860bef4af08c2403f3e131f6c913a2cbd6ddca4215b53'

  depends_on 'libraw1394'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
