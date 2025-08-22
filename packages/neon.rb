require 'package'

class Neon < Package
  description 'neon is an HTTP and WebDAV client library, with a C interface.'
  homepage 'http://www.webdav.org/neon/'
  version '0.35.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/notroj/neon.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f0b389b3d93942264f4f9bcec622c275b433e06ca4fe7f5ebe088ad5e6eec21',
     armv7l: '4f0b389b3d93942264f4f9bcec622c275b433e06ca4fe7f5ebe088ad5e6eec21',
     x86_64: '7e3f58e973fb3f32a4224b30c1002ae557570cdc91249b990bd75f1ff451ba41'
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
