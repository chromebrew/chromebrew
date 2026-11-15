require 'package'

class Netpbm < Package
  description 'Netpbm is a toolkit for manipulation of graphic images, including conversion of images between a variety of different formats.'
  homepage 'https://netpbm.sourceforge.net/'
  version '10.86.51'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/netpbm/super_stable/#{version}/netpbm-#{version}.tgz"
  source_sha256 '709a98e871aeae892437274d68833c804dd41a4b8daf8fd978cac2782da4148a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '676b83462a3464f58e8a26ed7d32206950ce54d4ce00ce08bc604e1c291a448f',
     armv7l: '676b83462a3464f58e8a26ed7d32206950ce54d4ce00ce08bc604e1c291a448f',
       i686: 'fafac86d9a275f6491f4f3d30a77031b3294521703a76b39c758242f01762544',
     x86_64: '6e6615039412d4b6e148dc4977f02cb5adc49b8e94abd7d3cecc25b2085028c8'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libjpeg_turbo' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libtiff' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'zlib' => :executable

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
