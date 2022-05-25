require 'package'

class Libavc1394 < Package
  description 'libavc1394 is a programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set.'
  homepage 'https://sourceforge.net/projects/libavc1394/'
  version '0.5.4-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libavc1394/libavc1394/libavc1394-0.5.4.tar.gz'
  source_sha256 '7cb1ff09506ae911ca9860bef4af08c2403f3e131f6c913a2cbd6ddca4215b53'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavc1394/0.5.4-1_armv7l/libavc1394-0.5.4-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavc1394/0.5.4-1_armv7l/libavc1394-0.5.4-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavc1394/0.5.4-1_i686/libavc1394-0.5.4-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libavc1394/0.5.4-1_x86_64/libavc1394-0.5.4-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '23401f9493493c0368a6fcc3039df80bfb840661b3f6846a45acc991856b149a',
     armv7l: '23401f9493493c0368a6fcc3039df80bfb840661b3f6846a45acc991856b149a',
       i686: '0097f563822dfbeb71df4d74d06a53df9a68e15bea70bfd677a22c3a71e0fb82',
     x86_64: '844ced6d6835b915bc7882ce5503e893c52426c9a789bc2aeb274bbf82dbc219'
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
