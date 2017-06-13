require 'package'

class Cadaver < Package
  description 'cadaver is a command-line WebDAV client for Unix. It supports file upload, download, on-screen display, namespace operations (move/copy), collection creation and deletion, and locking operations.'
  homepage 'http://www.webdav.org/cadaver/'
  version '0.23.3'
  source_url 'http://www.webdav.org/cadaver/cadaver-0.23.3.tar.gz'
  source_sha1 '4ad8ea2341b77e7dee26b46e4a8a496f1a2962cd'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
