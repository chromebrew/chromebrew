require 'buildsystems/autotools'

class Libnfs < Autotools
  description 'client library for accessing NFS shares'
  homepage 'https://github.com/sahlberg/libnfs'
  version '8.0.0'
  compatibility 'all'
  license 'GPL-3, LGPL-2.1 and BSD'
  source_url 'https://github.com/sahlberg/libnfs.git'
  git_hashtag "libnfs-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94e47a860804852f4e7ff51ae45d06dbf697091116b0550bd52965a86f04af29',
     armv7l: '94e47a860804852f4e7ff51ae45d06dbf697091116b0550bd52965a86f04af29',
       i686: 'ffd27e85345ee907ec173ebc9e847b0d3b3db526131456b74ce7da17aef1a64f',
     x86_64: 'aa1e70955c4a7d86cb36a17f621c650306208317171e36220c7c4c6c63b240a1'
  })

  depends_on 'brotli' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :executable
  depends_on 'gnutls' => :executable
  depends_on 'gnutls' => :library
  depends_on 'krb5' => :library
  depends_on 'libidn2' => :executable
  depends_on 'libtasn1' => :executable
  depends_on 'libunistring' => :executable
  depends_on 'nettle' => :executable
  depends_on 'p11kit' => :executable
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--enable-utils'
  autotools_pre_configure_options ('CFLAGS="$CFLAGS -Wno-cast-align"' if ARCH.include?('armv7l')).to_s
end
