require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.21.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/wget/wget-1.21.3.tar.lz'
  source_sha256 'dbd2fb5e47149d4752d0eaa0dac68cc49cf20d46df4f8e326ffc8f18b2af4ea5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libpsl'
  depends_on 'libidn2'
  depends_on 'pcre2'
  depends_on 'ca_certificates'

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system CREW_ENV_OPTIONS_HASH, <<~BUILD
      ./configure #{CREW_OPTIONS} \
        --sysconfdir=#{CREW_PREFIX}/etc \
        --without-libiconv-prefix \
        --with-ssl=openssl
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
