require 'buildsystems/autotools'

class Hexedit < Autotools
  version '1.6'
  description 'Hex Editor for Linux.'
  homepage 'http://rigaux.org/hexedit.html'
  license 'GPL-2'
  compatibility 'all'
  source_url "http://rigaux.org/hexedit-#{version}.src.tgz"
  source_sha256 '9fc7c8eb7002302612a0e4915f924cfcb83f042105861aa8dae234bd9bf8cc2d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b270260b8d198108cd7ceb77635bbe1cea82845954c7bea59d412fa76f50b43c',
     armv7l: 'b270260b8d198108cd7ceb77635bbe1cea82845954c7bea59d412fa76f50b43c',
       i686: '7bac8b5d6b4b73ee5a4ebc408ee19282490aeae415b5a611854685ba2ef45731',
     x86_64: '030c8807205f10df62e21c518e898fe57bf18f1b1b6a310801eb18a7df9d28eb'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CFLAGS=-I#{CREW_PREFIX}/include/ncursesw"

  def self.patch
    # Fix error: cannot find input file: 'hexedit.1.in'
    system "sed -i 's, hexedit.1,,g' configure"
  end
end
