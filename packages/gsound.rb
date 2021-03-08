require 'package'

class Gsound < Package
  description 'GSound is a small library for playing system sounds.'
  homepage 'https://wiki.gnome.org/Projects/GSound'
  @_app = name.tr('_', '-')
  @_fullver = '1.0.2'
  @_mainver = @_fullver.rpartition('.')[0]
  @_url = "https://download.gnome.org/sources/#{@_app}/#{@_mainver}/#{@_app}-#{@_fullver}"
  version @_fullver
  source_url "#{@_url}.tar.xz"
  source_sha256 `curl -Ls #{@_url}.sha256sum | tail -n1 | cut -d ' ' -f1`.chomp
  
  depends_on 'gobject_introspection'
  depends_on 'libcanberra'

  def self.build
    system './autogen.sh' if File.exist?('autogen.sh')
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto' \
            ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system "make", "check"
  end
end
