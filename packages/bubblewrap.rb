require 'package'

class Bubblewrap < Package
  description 'bubblewrap works by creating a new, completely empty, mount namespace'
  homepage 'https://github.com/containers/bubblewrap'
  version '0.4.1'
  compatibility 'all'
  source_url 'https://github.com/containers/bubblewrap/releases/download/v0.4.1/bubblewrap-0.4.1.tar.xz'
  source_sha256 'b9c69b9b1c61a608f34325c8e1a495229bacf6e4a07cbb0c80cf7a814d7ccc03'

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --disable-maintainer-mode \
            --disable-man \
            --with-priv-mode=setuid \
            --enable-sudo"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
