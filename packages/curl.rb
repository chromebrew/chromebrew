require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.75.0'
  version @_ver
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 'fe0c49d8468249000bda75bcfdf9e30ff7e9a86d35f1a21f428d79c389d55675'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/curl-7.75.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6d0b932c52ecb2ca3dec9e6f713804d632e0744c243019c93fc92eabe5a01edd',
     armv7l: '6d0b932c52ecb2ca3dec9e6f713804d632e0744c243019c93fc92eabe5a01edd',
       i686: '8944cd73ecbc7cbda1a3afc18aafdea28486baad7b7664d6b16c3ccc23ca2c07',
     x86_64: 'a511db565f40b830a623a173739d29a3c935ea2698ebb407b65a630d1e279b17'
  })

  depends_on 'groff' => :build
  depends_on 'brotli'
  depends_on 'c_ares'
  depends_on 'libidn2'
  depends_on 'libmetalink'
  depends_on 'libnghttp2'
  depends_on 'libtirpc'
  depends_on 'libunbound'
  depends_on 'openldap'
  depends_on 'zstd'
  depends_on 'rtmpdump'

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'  LDFLAGS='-flto=auto'\
    ./configure #{CREW_OPTIONS} \
    --disable-maintainer-mode \
    --enable-ares \
    --with-ldap-lib=ldap \
    --with-lber-lib=lber \
    --with-libmetalink"
    system 'make'
  end

  def self.check
    # Python package impacket needed for testing.
    # 1094 tests out of 1097 reported OK: 99% on 10/25/2020
    # The 3 tests that failed were FTP, SMB and GOPHER.
    # system 'pip3 install impacket'
    # system 'make check || true'
    # system 'pip3 uninstall -y impacket'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
