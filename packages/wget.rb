require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.21.4'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftp.gnu.org/gnu/wget/wget-1.21.4.tar.lz'
  source_sha256 '3683619a5f50edcbccb1720a79006fa37bf9b9a255a8c5b48048bc3c7a874bd9'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.4_armv7l/wget-1.21.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.4_armv7l/wget-1.21.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.4_i686/wget-1.21.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.4_x86_64/wget-1.21.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0368ea4f0282ddf29bc0ddf501a1da5fa6bc249e80aa6184eaaf69b173857571',
     armv7l: '0368ea4f0282ddf29bc0ddf501a1da5fa6bc249e80aa6184eaaf69b173857571',
       i686: '1bc698a3e6677c6a84face27747a4fc490199a4c390c25e3566eaaac870eddae',
     x86_64: '8d294bc5965308fd89d4d87dcd6f2c3610210fe73546a690c7ccaf744ade5c2b'
  })

  depends_on 'ca_certificates' # L
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libidn2' # R
  depends_on 'libmetalink' # R
  depends_on 'libpsl' # R
  depends_on 'libunistring' # R
  depends_on 'openssl' # R
  depends_on 'pcre2' # R
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R

  no_env_options

  def self.build
    @lto = ARCH == 'i686' ? '' : '-flto=auto'
    system "CFLAGS='-O2 -pipe #{@lto} -fPIC' LDFLAGS=#{@lto} LD=mold \
      ./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc \
      --with-ssl=openssl"
    system 'make'
  end

  def self.check
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    File.write "#{CREW_DEST_PREFIX}/etc/wgetrc", "ca_directory=#{CREW_PREFIX}/etc/ssl/certs\n", mode: 'a'
  end
end
