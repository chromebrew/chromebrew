require 'package'

class Libstfl < Package
  description 'libSTFL is a library that implements a curses-based widget set for text terminals.'
  homepage 'http://www.clifford.at/stfl/'
  version '0.23'
  license 'GPL-3'
  compatibility 'all'
  source_url 'http://www.clifford.at/stfl/stfl-0.23.tar.gz'
  source_sha256 'e75ed8427905ad50faf43ed5fefd0cf7b16ee0c1ca87e15d33e360bb92aedfde'

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
    IO.write("ruby_extconf.patch", @ruby_extconf)
    system "patch -Np1 -i ruby_extconf.patch"
    system "sed -i 's,all: libstfl.so.$(VERSION) libstfl.a example,all: libstfl.so.$(VERSION) libstfl.a,' Makefile"
  end

  def self.build
    system "make libstfl.a"
    system "make libstfl.so.0.23"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir "#{CREW_DEST_PREFIX}" do
      FileUtils.mv 'lib', "#{CREW_DEST_LIB_PREFIX}" if "#{CREW_LIB_SUFFIX}" == '64'
    end
    Dir.chdir "#{CREW_DEST_LIB_PREFIX}" do
      FileUtils.symlink 'libstfl.so.0.23', 'libstfl.so.0'
    end
  end
end
