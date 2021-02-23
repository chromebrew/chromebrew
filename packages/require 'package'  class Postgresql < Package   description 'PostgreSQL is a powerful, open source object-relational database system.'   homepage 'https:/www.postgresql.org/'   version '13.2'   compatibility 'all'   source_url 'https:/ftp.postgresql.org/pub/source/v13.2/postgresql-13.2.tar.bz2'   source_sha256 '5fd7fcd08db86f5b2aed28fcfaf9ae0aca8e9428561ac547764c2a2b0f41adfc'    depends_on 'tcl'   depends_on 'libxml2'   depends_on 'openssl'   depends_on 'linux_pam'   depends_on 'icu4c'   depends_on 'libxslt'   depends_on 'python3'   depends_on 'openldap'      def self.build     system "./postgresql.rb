require 'package'

class Postgresql < Package
  description 'PostgreSQL is a powerful, open source object-relational database system.'
  homepage 'https://www.postgresql.org/'
  version '13.2'
  compatibility 'all'
  source_url 'https://ftp.postgresql.org/pub/source/v13.2/postgresql-13.2.tar.bz2'
  source_sha256 '5fd7fcd08db86f5b2aed28fcfaf9ae0aca8e9428561ac547764c2a2b0f41adfc'

  depends_on 'tcl'
  depends_on 'libxml2'
  depends_on 'openssl'
  depends_on 'linux_pam'
  depends_on 'icu4c'
  depends_on 'libxslt'
  depends_on 'python3'
  depends_on 'openldap'
  
  def self.build
    system "./configure #{CREW_OPTIONS} \
            --enable-depend \
            --enable-thread-safety \
            --without-llvm \
            --with-icu \
            --with-tcl \
            --with-perl \
            --with-python \
            --with-gssapi \
            --with-pam \
            --without-bonjour \
            --with-ldap \
            --with-openssl \
            --without-systemd \
            --with-readline \
            --with-libxml \
            --with-zlib \
            --with-libxslt"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
