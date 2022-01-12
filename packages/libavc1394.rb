require 'package'

class Libavc1394 < Package
  description 'libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set.'
  homepage 'https://sourceforge.net/projects/libavc1394/'
  version '0.5.4-1'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://downloads.sourceforge.net/project/libavc1394/libavc1394/libavc1394-0.5.4.tar.gz'
  source_sha256 '7cb1ff09506ae911ca9860bef4af08c2403f3e131f6c913a2cbd6ddca4215b53'

  binary_url ({
     aarch64: 'file:///usr/local/tmp/packages/libavc1394-0.5.4-1-chromeos-armv7l.tpxz',
      armv7l: 'file:///usr/local/tmp/packages/libavc1394-0.5.4-1-chromeos-armv7l.tpxz',
        i686: 'file:///usr/local/tmp/packages/libavc1394-0.5.4-1-chromeos-i686.tpxz',
      x86_64: 'file:///usr/local/tmp/packages/libavc1394-0.5.4-1-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
     aarch64: '58d8363b74e0bedfd11ae22835f0032a8f91f5bef61d0c06b146cc5bd13d51bd',
      armv7l: '58d8363b74e0bedfd11ae22835f0032a8f91f5bef61d0c06b146cc5bd13d51bd',
        i686: '0c18c2d74748e2cbb0c08f85741a71220909c0ffff020066cc307cf8878c0dad',
      x86_64: '7c875d65b15e5cd43f51965743a7f79453982399aed94bcd0ed93e9104314ad1',
  })

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
