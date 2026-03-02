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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libtiff' # R
  depends_on 'libxml2' # R
  depends_on 'zlib' # R

  def self.patch
    # Change installation directories.
    system "sed -i 's,/etc/,#{CREW_DEST_PREFIX}/etc/,g' buildtools/installnetpbm.pl"
    system "sed -i 's,/usr/local/netpbm,#{CREW_DEST_PREFIX},' buildtools/installnetpbm.pl"
    # Fix error: ‘bool’ cannot be defined via ‘typedef’
    system "sed -i 's,typedef unsigned char bool;,#include <stdbool.h>,' buildtools/libopt.c"
    # Do not build pamx.
    system "sed -i '/SUBDIRS = pamx/d' other/Makefile"
  end

  def self.build
    system 'yes "" | ./configure'
    system 'make'
    system 'make', 'package'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system 'yes "" | ./installnetpbm'
    if ARCH.eql?('x86_64')
      FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/*"], CREW_DEST_LIB_PREFIX
    end
  end
end
