require 'package'

class Neon < Package
  description 'neon is an HTTP and WebDAV client library, with a C interface.'
  homepage 'http://www.webdav.org/neon/'
  version '0.37.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/notroj/neon.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '829ded8698de05a688550be810c50f8c119f14692e0332a86a8fe234df8b71e5',
     armv7l: '829ded8698de05a688550be810c50f8c119f14692e0332a86a8fe234df8b71e5',
     x86_64: 'f93d7a5415886e4181a88fb99c409d43c539755808665ccd6d96ca1453f6a149'
  })

  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libproxy' # R
  depends_on 'openssl' # R
  depends_on 'xmlto' => :build
  depends_on 'zlib' # R

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "./configure \
            #{CREW_CONFIGURE_OPTIONS} \
           --enable-shared=yes \
           --with-ssl=openssl"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-lib', 'install-headers', 'install-config'
    Dir.chdir(CREW_DEST_LIB_PREFIX) do
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/libneon.so", 'neon.so'
    end
  end
end
