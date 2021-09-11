require 'package'

class Wget < Package
  description 'GNU Wget is a free software package for retrieving files using HTTP, HTTPS, FTP and FTPS.'
  homepage 'https://www.gnu.org/software/wget/'
  version '1.21.2'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/wget/wget-1.21.2.tar.gz'
  source_sha256 'e6d4c76be82c676dd7e8c61a29b2ac8510ae108a810b5d1d18fc9a1d2c9a2497'

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
