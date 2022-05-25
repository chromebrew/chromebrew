require 'package'

class Nping < Package
  description 'Nping is part of the nmap suite - a network diagnostics tool`.'
  homepage 'https://nmap.org/nping/'
  version '7.60'
  license 'NPSL'
  compatibility 'all'
  source_url 'https://nmap.org/dist/nmap-7.60.tar.bz2'
  source_sha256 'a8796ecc4fa6c38aad6139d9515dc8113023a82e9d787e5a5fb5fa1b05516f21'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nping/7.60_armv7l/nping-7.60-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nping/7.60_armv7l/nping-7.60-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nping/7.60_i686/nping-7.60-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nping/7.60_x86_64/nping-7.60-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e57915081b9648b6f4ea639a40f611306d870fced74b47ee3438daa8414e1921',
     armv7l: 'e57915081b9648b6f4ea639a40f611306d870fced74b47ee3438daa8414e1921',
       i686: 'a45af5836acefe2c9aad17a732cea4edad65e272d079d574c8dbf3cfdab26910',
     x86_64: '558f8cc197f92003dfd44adab12ec4461b594f322e41d0498a8e961ae030f00a'
  })

  depends_on 'buildessential' => :build
  depends_on 'filecmd' => :build # configure uses file

  def self.build
    # fixup "/usr/bin/file" -> "file" in the configure script

    system "sed -i s#/usr/bin/file##{CREW_PREFIX}/bin/file#g libdnet-stripped/configure"

    # without-zenmap in configure removes openssl dependency
    system "./configure --without-zenmap --prefix=#{CREW_PREFIX}"

    # Make files in the project don't have the right dependencies to build this by itself
    # so just make the whole thing and then install nping - not efficient, but
    # more likely to work than a bunch of Makefile dependency edits
    system 'make'
  end

  def self.install
    system "cd nping && make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
