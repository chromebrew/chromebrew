require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  @_ver = '1.21.1'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/wget/wget-#{@_ver}.tar.lz"
  source_sha256 'db9bbe5347e6faa06fc78805eeb808b268979455ead9003a608569c9d4fc90ad'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '407cb0b92209fe7c9f967a9b2b68134ba747bbbbd622328a89353bad524739c4',
     armv7l: '407cb0b92209fe7c9f967a9b2b68134ba747bbbbd622328a89353bad524739c4',
       i686: '342544c5ac5b6634edc3323c94a94d16a3cd8e5c7d4d695e5481e51d0608dc52',
     x86_64: 'bd779500c54435989731f1f40918a7bd58065f6da5ea562f332412fa88dc833d'
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
  depends_on 'libxdmcp'
  depends_on 'libmetalink'
  depends_on 'pcre2'
  depends_on 'ca_certificates'
  
  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc\
      --with-metalink \
      --without-libiconv-prefix"
    system 'make'
  end

  def self.check
    # system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "echo \"ca_directory=#{CREW_PREFIX}/etc/ssl/certs\" >> #{CREW_DEST_PREFIX}/etc/wgetrc"
  end
end
