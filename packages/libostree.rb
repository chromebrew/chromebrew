require 'buildsystems/autotools'

class Libostree < Autotools
  description 'libostree manages operating system and container binary deployment and upgrades.'
  homepage 'https://ostreedev.github.io/ostree/'
  version '2024.9'
  license 'LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/ostreedev/ostree/releases/download/v#{version}/libostree-#{version}.tar.xz"
  source_sha256 '4356170ec5f7a09428b6add77e2c6f31d4049ab765ee67cf929bfa3b750d3e1b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'afb793c59fb8c3c6fb332c09d0afb901f8b776122e0990a312a63c0c1bbf54e0',
     armv7l: 'afb793c59fb8c3c6fb332c09d0afb901f8b776122e0990a312a63c0c1bbf54e0',
     x86_64: 'bc80e7c50fec8d70f6024991eae569080d6fed8e3da7ec51ce5cea0f2bb3039e'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'avahi' # R
  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'c_ares' # R
  depends_on 'curl' # R
  depends_on 'dbus' # R
  depends_on 'e2fsprogs' => :build
  depends_on 'fuse3' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gpgme' # R
  depends_on 'gtk_doc' => :build
  depends_on 'libarchive' # R
  depends_on 'libassuan' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libgpg_error' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libsoup' => :build
  depends_on 'libssh' # R
  depends_on 'libssp' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'util_linux' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  configure_options '--disable-rofiles-fuse \
      --with-curl \
      --without-libsystemd \
      --with-avahi \
      --with-libarchive \
      --disable-gtk-doc \
      --disable-man' # gtk-doc and man failed to build, causes make to fail

  def self.prebuild
    ConvenienceFunctions.libtoolize('libxml2')
  end
end
