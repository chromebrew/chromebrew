require 'buildsystems/autotools'

class Libostree < Autotools
  description 'libostree manages operating system and container binary deployment and upgrades.'
  homepage 'https://ostreedev.github.io/ostree/'
  version '2024.9'
  license 'LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/ostreedev/ostree/releases/download/v#{version}/libostree-#{version}.tar.xz"
  source_sha256 '4356170ec5f7a09428b6add77e2c6f31d4049ab765ee67cf929bfa3b750d3e1b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1136bea46e168c2be48e029a9b084f56d32ab3d7023ca13a17eb96f1829575c9',
     armv7l: '1136bea46e168c2be48e029a9b084f56d32ab3d7023ca13a17eb96f1829575c9',
     x86_64: '175a202b1843d9c26ea579d5896530198f74ff201de46ed89a92473299197657'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'avahi' # R
  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'c_ares' # R
  depends_on 'curl' # R
  depends_on 'dbus' # R
  depends_on 'docbook_xml' => :build
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

  autotools_configure_options '--disable-rofiles-fuse \
      --with-curl \
      --without-libsystemd \
      --with-avahi \
      --with-libarchive'

  def self.prebuild
    ConvenienceFunctions.libtoolize('libxml2')
  end
end
