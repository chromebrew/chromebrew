require 'package'

class Neon < Package
  description 'neon is an HTTP and WebDAV client library, with a C interface.'
  homepage 'http://www.webdav.org/neon/'
  version '0.32.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/notroj/neon.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0444e7c0c3b6ae6b97b355a802491cae583bfd534af2024f64470e87a348cc47',
     armv7l: '0444e7c0c3b6ae6b97b355a802491cae583bfd534af2024f64470e87a348cc47',
       i686: '45fa4c37e2a64bfbd332a924cacbf5772520b58fd751601aaf984a9ff4e31bfb',
     x86_64: '16f0fdbfd3768f2860a252853731d125cffc0051aa64a5e108b9b758059eeeb6'
  })

  depends_on 'xmlto' => :build
  depends_on 'expat' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libproxy' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "./configure \
            #{CREW_OPTIONS} \
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
