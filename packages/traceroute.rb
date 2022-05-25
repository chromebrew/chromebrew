require 'package'

class Traceroute < Package
  description 'Traceroute tracks the route packets taken from an IP network on their way to a given host.'
  homepage 'http://traceroute.sourceforge.net/'
  version '2.1.4'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/traceroute/traceroute/traceroute%202.1.4/traceroute-2.1.4.tar.gz'
  source_sha256 'b2e39a1d04ea45a6a60c976a2637d1a16224edd2eaa19a5870af83edb2ffe3fa'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/traceroute/2.1.4_armv7l/traceroute-2.1.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/traceroute/2.1.4_armv7l/traceroute-2.1.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/traceroute/2.1.4_i686/traceroute-2.1.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/traceroute/2.1.4_x86_64/traceroute-2.1.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '80d2764b34cc364107065ce9a3ae76d61a2565fb4840a37642e68ffc500bfbf5',
     armv7l: '80d2764b34cc364107065ce9a3ae76d61a2565fb4840a37642e68ffc500bfbf5',
       i686: '1a2894202e959c53295e1559d3a7b9056199903848b5a4e81cc864c1ef4aa52f',
     x86_64: '141f1dcdeb4797c34aa985607c861115380d49a44f21390c5b436196d4d205bc'
  })

  def self.build
    # add /usr/lib64 to vpath to check /usr/lib64/libm.so
    system 'sed', '-i', 'Make.rules', '-e', '/vpath lib%.so/s:$: /usr/lib64:'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
