require 'package'

class Libxcomposite < Package
  description 'X.org X Composite Library'
  homepage 'http://www.x.org'
  @_ver = '0.4.5'
  version @_ver
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXcomposite-#{@_ver}.tar.gz"
  source_sha256 '581c7fc0f41a99af38b1c36b9be64bc13ef3f60091cd3f01105bbc7c01617d6c'


  depends_on 'libxfixes'
  depends_on 'libxext'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.check
    system 'make', 'check'
  end
end
