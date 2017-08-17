require 'package'

class Libwayland < Package
  description 'Wayland is intended as a simpler replacement for X, easier to develop and maintain.'
  homepage 'https://wayland.freedesktop.org'
  version '1.32.92'
  source_url 'https://wayland.freedesktop.org/releases/wayland-1.13.92.tar.xz'
  source_sha256 '1253392261ccb44b312ec0486457c28d24c2f9d8940162181ed5ddc568b8f858'

  depends_on 'libffi'
  depends_on 'expat'
  depends_on 'libxml2'

  def self.build
    system "./configure --disable-documentation"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
