require 'package'

class Libostree < Package
  description 'libostree manages operating system and container binary deployment and upgrades.'
  homepage 'https://ostreedev.github.io/ostree/'
  version '2020.8'
  compatibility 'all'
  source_url 'https://github.com/ostreedev/ostree/releases/download/v2020.8/libostree-2020.8.tar.xz'
  source_sha256 'fdaa5992d0a6f62157152355449ac8476c50df6602be398e9ad10438cc1e679b'

  depends_on 'glib'
  depends_on 'gpgme'
  depends_on 'libsoup'
  depends_on 'e2fsprogs'
  depends_on 'fuse'
  depends_on 'libarchive'
  depends_on 'avahi'
  depends_on 'gtk_doc' => :build
  depends_on 'libxml2' => :build
  
  def self.build
    system "./autogen.sh #{CREW_OPTIONS} \
            --with-curl \
            --without-libsystemd \
            --with-avahi \
            --with-libarchive \
            --disable-gtk-doc \
            --disable-man" #gtk-doc and man failed to build, causes make to fail
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
