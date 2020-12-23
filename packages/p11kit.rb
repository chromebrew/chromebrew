require 'package'

class P11kit < Package
  description "Provides a standard configuration setup for installing PKCS#11 modules in such a way that they're discoverable."
  homepage 'https://p11-glue.freedesktop.org/p11-kit.html'
  version '0.23.22'
  compatibility 'all'
  source_url 'https://github.com/p11-glue/p11-kit/archive/0.23.22.tar.gz'
  source_sha256 'e4bf1e374b3c0950a724cf367bd52201519f4b7025c8e9902a274123cc232560'

 
  depends_on 'libffi'
  depends_on 'libtasn1'
  
  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      build"
    system "meson configure build"
    system "ninja -C build"
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

end
