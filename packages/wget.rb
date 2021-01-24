require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  @_ver = '1.21.1'
  version @_ver
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/wget/wget-#{@_ver}.tar.lz"
  source_sha256 'db9bbe5347e6faa06fc78805eeb808b268979455ead9003a608569c9d4fc90ad'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wget-1.21.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c365e53c36d6927b761ed7c1293f2506e289d13694fa5de9882087e5444cf185',
      armv7l: 'c365e53c36d6927b761ed7c1293f2506e289d13694fa5de9882087e5444cf185',
        i686: '399d68710cf8bb0924cad818f85bb38c2ba3d68d2a3dff494f21e9727a7069fe',
      x86_64: '583bd6f6a1f1aacbd0faafcd5d9ffa6405825ea2c0d41aa7bd2e134a8a67f6c4',
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
  depends_on 'libxdmcp'
  depends_on 'libmetalink'
  depends_on 'pcre2'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' ./configure #{CREW_OPTIONS} --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.check
    #system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
