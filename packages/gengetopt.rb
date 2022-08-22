require 'package'

class Gengetopt < Package
  description 'This program generates a C function that uses getopt_long function to parse the command line options, to validate them and fills a struct .'
  homepage 'https://www.gnu.org/software/gengetopt/'
  version '2.22.6'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gengetopt/gengetopt-2.22.6.tar.gz'
  source_sha256 '30b05a88604d71ef2a42a2ef26cd26df242b41f5b011ad03083143a31d9b01f7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.22.6_armv7l/gengetopt-2.22.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.22.6_armv7l/gengetopt-2.22.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.22.6_i686/gengetopt-2.22.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gengetopt/2.22.6_x86_64/gengetopt-2.22.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7e306c8b415392c657bbc244edb617b91426ed08936751145434b0bbf4bfd04d',
     armv7l: '7e306c8b415392c657bbc244edb617b91426ed08936751145434b0bbf4bfd04d',
       i686: '08953a3621340f6200f5a5723784d1e89db0f2cf7f09fd45ee00ed05c03d6fc6',
     x86_64: '75c36bc7b44192695691b36009d2fa733dc7573cbb3f83c084ea45a57dcfdcda'
  })

  def self.build
    system "sed -i 's,/usr/bin/file,#{CREW_PREFIX}/bin/file,g' configure"
    system "./configure --prefix=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
