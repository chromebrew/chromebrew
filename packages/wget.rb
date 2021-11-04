require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.21.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/wget/wget-1.21.2.tar.gz'
  source_sha256 'e6d4c76be82c676dd7e8c61a29b2ac8510ae108a810b5d1d18fc9a1d2c9a2497'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.2_armv7l/wget-1.21.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.2_armv7l/wget-1.21.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.2_i686/wget-1.21.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wget/1.21.2_x86_64/wget-1.21.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c2179f28acacdff15012005c0949712366045e1a40dc0682f8aa5b1758cffef6',
     armv7l: 'c2179f28acacdff15012005c0949712366045e1a40dc0682f8aa5b1758cffef6',
       i686: 'a80b25da86146cd54a35c534705e4dc2ccd5839f17e5c85f5ab3626018091dee',
     x86_64: '792bbb12e594477ab1857749dab3f878edaa736307b100c235b987ce25bc144c',
  })

  depends_on 'gnutls'
  depends_on 'libpsl'
  depends_on 'libxdmcp'
  depends_on 'libmetalink'
  depends_on 'pcre2'
  depends_on 'ca_certificates'

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system <<~BUILD
      #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
        --sysconfdir=#{CREW_PREFIX}/etc \
        --with-metalink \
        --without-libiconv-prefix
    BUILD
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
