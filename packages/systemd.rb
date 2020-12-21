require 'package'

class Systemd < Package
  description 'The systemd System and Service Manager'
  homepage 'https://systemd.io/'
  version '247'
  compatibility 'all'
  source_url 'https://github.com/systemd/systemd/archive/v247.tar.gz'
  source_sha256 '77146f7b27334aa69ef6692bed92c3c893685150f481e7254b81d4ea0f66c640'
    
  depends_on 'p11_kit'
  depends_on 'libgcrypt'
  depends_on 'libcap'
  depends_on 'gperf'
  depends_on 'glib'
    
  ENV['CC'] = 'clang'
  ENV['CXX'] = 'clang'
  ENV['LD'] = 'lld'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end