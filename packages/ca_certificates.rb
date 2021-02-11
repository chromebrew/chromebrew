require 'package'

class Ca_certificates < Package
  description 'CA Certificates'
  homepage 'https://salsa.debian.org/debian/ca-certificates'
  @_ver = '20210119'
  version @_ver
  compatibility 'all'
  source_url "https://salsa.debian.org/debian/ca-certificates/-/archive/debian/#{@_ver}/ca-certificates-debian-#{@_ver}.tar.bz2"
  source_sha256 'af30b4d9a2c58e42134067d29f0ba6120e5960fd140393d5574d4bdcf5b824d6'

  def self.patch
    system "sed -i 's,/usr/share/ca-certificates,#{CREW_PREFIX}/share/ca-certificates,g' \
      Makefile"
    system "sed -i 's,/usr/share/ca-certificates,#{CREW_PREFIX}/share/ca-certificates,g' \
      sbin/update-ca-certificates"
    system "sed -i 's,CERTSCONF=/etc/ca-certificates.conf,CERTSCONF=#{CREW_PREFIX}/etc/ca-certificates.conf,g' \
      sbin/update-ca-certificates"
    system "sed -i 's,ETCCERTSDIR=/etc/ssl/certs,ETCCERTSDIR=#{CREW_PREFIX}/etc/ssl/certs,g' \
      sbin/update-ca-certificates"
    system "sed -i 's,HOOKSDIR=/etc/ca-certificates/update.d,HOOKSDIR=#{CREW_PREFIX}/etc/ca-certificates/update.d,g' \
      sbin/update-ca-certificates"
    system "sed -i '/restorecon/d' sbin/update-ca-certificates"
    system "sed -i 's,/usr/sbin,#{CREW_PREFIX}/bin,g' sbin/Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/etc/ssl/certs/")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/bin")
    FileUtils.mkdir_p("#{CREW_DEST_PREFIX}/share/ca-certificates/")
    system "touch #{CREW_DEST_PREFIX}/etc/ca-certificates.conf"
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    FileUtils.ln_s Dir.glob("#{CREW_PREFIX}/share/ca-certificates/mozilla/*"),
                   "#{CREW_DEST_PREFIX}/etc/ssl/certs/"
  end

  def self.postinstall
    system 'update-ca-certificates --hooksdir "" --fresh'
  end
end
