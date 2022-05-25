require 'package'

class Libostree < Package
  description 'libostree manages operating system and container binary deployment and upgrades.'
  homepage 'https://ostreedev.github.io/ostree/'
  version '2020.8'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/ostreedev/ostree/releases/download/v#{version}/libostree-#{version}.tar.xz"
  source_sha256 'fdaa5992d0a6f62157152355449ac8476c50df6602be398e9ad10438cc1e679b'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libostree/2020.8_armv7l/libostree-2020.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libostree/2020.8_armv7l/libostree-2020.8-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libostree/2020.8_i686/libostree-2020.8-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libostree/2020.8_x86_64/libostree-2020.8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4e4ffd30a74ea73c60f7b0c9a0064a50dacf31ad0d8011f95deb35fab596878d',
     armv7l: '4e4ffd30a74ea73c60f7b0c9a0064a50dacf31ad0d8011f95deb35fab596878d',
       i686: '11a240d4f4ecaf37865a1c29c457d8eda6973082babea87f6d9cc7580579c930',
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
