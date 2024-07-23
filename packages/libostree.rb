require 'package'

class Libostree < Package
  description 'libostree manages operating system and container binary deployment and upgrades.'
  homepage 'https://ostreedev.github.io/ostree/'
  version '2020.8'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/ostreedev/ostree/releases/download/v#{version}/libostree-#{version}.tar.xz"
  source_sha256 'fdaa5992d0a6f62157152355449ac8476c50df6602be398e9ad10438cc1e679b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '4e4ffd30a74ea73c60f7b0c9a0064a50dacf31ad0d8011f95deb35fab596878d',
     armv7l: '4e4ffd30a74ea73c60f7b0c9a0064a50dacf31ad0d8011f95deb35fab596878d',
     x86_64: '9dade5c1d720715fdb3f6841093db55b1a6c57b10694acd61c1ab306c74047cc'
  })

  depends_on 'glib'
  depends_on 'gpgme'
  depends_on 'libsoup'
  depends_on 'e2fsprogs'
  depends_on 'fuse3'
  depends_on 'libarchive'
  depends_on 'avahi'
  depends_on 'gtk_doc' => :build

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS} \
      --with-curl \
      --without-libsystemd \
      --with-avahi \
      --with-libarchive \
      --disable-gtk-doc \
      --disable-man" # gtk-doc and man failed to build, causes make to fail
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
