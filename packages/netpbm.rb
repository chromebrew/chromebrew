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
    aarch64: '05f9b56a49c5c0464f9fc75c92dec98ea9c621259d29c7a9e8da02565aaf97ce',
     armv7l: '05f9b56a49c5c0464f9fc75c92dec98ea9c621259d29c7a9e8da02565aaf97ce',
       i686: '85c1926bf1068365a062fb50fc2e5cb937be4a7693c7e09caf0c66d2e20731af',
     x86_64: '340a481d769de24609e4b01b7a44686afd4b2afe4ff531e594a8102b7c32ea23'
  })

  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo' => :executable_only
  depends_on 'libpng' => :executable_only
  depends_on 'libtiff' => :executable_only
  depends_on 'libxml2' => :executable_only
  depends_on 'zlib' => :executable_only

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
