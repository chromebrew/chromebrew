require 'package'

class Libstfl < Package
  description 'libSTFL is a library that implements a curses-based widget set for text terminals.'
  homepage 'http://www.clifford.at/stfl/'
  version '0.23'
  license 'GPL-3'
  compatibility 'all'
  source_url 'http://www.clifford.at/stfl/stfl-0.23.tar.gz'
  source_sha256 'e75ed8427905ad50faf43ed5fefd0cf7b16ee0c1ca87e15d33e360bb92aedfde'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '68532ced7ade579392d5d3ab4e9ea70f8282f5ec8a981770e6976411f496266d',
     armv7l: '68532ced7ade579392d5d3ab4e9ea70f8282f5ec8a981770e6976411f496266d',
       i686: '4240b0d2723ce868824e7109a2549e5f86566877cb738242b2024139525df8ed',
     x86_64: '285f8fd5fc05bb37e4dfc7cba8e8f3e81dc1637aeb1fa98ffba3e53b05581c12'
  })

  def self.patch
    @ruby_extconf = <<~EOF
      --- a/ruby/extconf.rb
      +++ b/ruby/extconf.rb
      @@ -1,2 +1,5 @@
       require 'mkmf'
      +`swig -ruby stfl.i`
      +$LIBS << " ../libstfl.a -lncursesw"
      +$CFLAGS << " -I.. -fPIC"
       create_makefile('stfl')
    EOF
    File.write('ruby_extconf.patch', @ruby_extconf)
    system 'patch -Np1 -i ruby_extconf.patch'
    system "sed -i 's,all: libstfl.so.$(VERSION) libstfl.a example,all: libstfl.so.$(VERSION) libstfl.a,' Makefile"
  end

  def self.build
    system 'make libstfl.a'
    system 'make libstfl.so.0.23'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir CREW_DEST_PREFIX do
      FileUtils.mv 'lib', CREW_DEST_LIB_PREFIX if CREW_LIB_SUFFIX.to_s == '64'
    end
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.symlink 'libstfl.so.0.23', 'libstfl.so.0'
    end
  end
end
