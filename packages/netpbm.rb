require 'package'

class Netpbm < Package
  description 'Netpbm is a toolkit for manipulation of graphic images, including conversion of images between a variety of different formats.'
  homepage 'https://netpbm.sourceforge.net/'
  version '10.86.48'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/netpbm/super_stable/#{version}/netpbm-#{version}.tgz"
  source_sha256 '709a98e871aeae892437274d68833c804dd41a4b8daf8fd978cac2782da4148a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f4dd0de3f9af1423121ba6e82ddc268863fadaf50222a51dc2026652e99fefb',
     armv7l: '2f4dd0de3f9af1423121ba6e82ddc268863fadaf50222a51dc2026652e99fefb',
       i686: '3a900cd5917c750a09f5d9e5f5845c2cfe1a02539c3ad8ef63d0a291ea0f1c64',
     x86_64: '06375d9b711b7a03a26e8d00d84c3a13f3d1c2bc3cff16442c39b29c7ca2a58f'
  })

  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libx11' # R
  depends_on 'libxml2' # R
  depends_on 'zlib' # R

  def self.patch
    # Change installation directories.
    system "sed -i 's,/etc/,#{CREW_DEST_PREFIX}/etc/,g' buildtools/installnetpbm.pl"
    system "sed -i 's,/usr/local/netpbm,#{CREW_DEST_PREFIX},' buildtools/installnetpbm.pl"
    # Update scripts to be non-interactive.
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' buildtools/configure.pl"
    system "sed -i 's/prompt(\".*\", \$default)/\$default/g' buildtools/configure.pl"
    system "sed -i 's/prompt(\".*\", \$default)/\$default/g' buildtools/installnetpbm.pl"
    system "sed -i 's/fsObjPrompt(\"install prefix\", \$default)/\$default/' buildtools/installnetpbm.pl"
    system "sed -i 's/fsObjPrompt(\".*\", \$default)/\$default/g' buildtools/installnetpbm.pl"
    # Fix error: ‘bool’ cannot be defined via ‘typedef’
    system "sed -i 's,typedef unsigned char bool;,#include <stdbool.h>,' buildtools/libopt.c"
  end

  def self.build
    system 'yes|./configure'
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    system 'yes|./installnetpbm'
    if ARCH.eql?('x86_64')
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX
    end
    FileUtils.rm_f '/tmp/netpbm'
  end
end
