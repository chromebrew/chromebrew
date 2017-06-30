require 'package'

class Cadaver < Package
  description 'cadaver is a command-line WebDAV client for Unix. It supports file upload, download, on-screen display, namespace operations (move/copy), collection creation and deletion, and locking operations.'
  homepage 'http://www.webdav.org/cadaver/'
  version '0.23.3'
  source_url 'http://www.webdav.org/cadaver/cadaver-0.23.3.tar.gz'
  source_sha256 'fd4ce68a3230ba459a92bcb747fc6afa91e46d803c1d5ffe964b661793c13fca'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
