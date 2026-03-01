require 'package'

class Neon < Package
  description 'neon is an HTTP and WebDAV client library, with a C interface.'
  homepage 'http://www.webdav.org/neon/'
  version '0.37.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/notroj/neon.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '524ce6754fd9e659a53c82b3834375b48d954f7cc3fee1fc63b7ce765e875433',
     armv7l: '524ce6754fd9e659a53c82b3834375b48d954f7cc3fee1fc63b7ce765e875433',
     x86_64: 'e3600f6a9851b634f08591daf501881b843a6ce93a29aea6735b5c76f9f2d72c'
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
