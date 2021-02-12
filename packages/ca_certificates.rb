require 'package'

class Ca_certificates < Package
  description 'CA Certificates'
  homepage 'https://salsa.debian.org/debian/ca-certificates'
  @_ver = '20210119'
  version @_ver
  compatibility 'all'
  source_url "https://salsa.debian.org/debian/ca-certificates/-/archive/debian/#{@_ver}/ca-certificates-debian-#{@_ver}.tar.bz2"
  source_sha256 'af30b4d9a2c58e42134067d29f0ba6120e5960fd140393d5574d4bdcf5b824d6'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ca_certificates-20210119-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '75d332ca6053e5e12d34eb5d72da6daab50d650f6733d1bd9668bed9af802e30',
      armv7l: '75d332ca6053e5e12d34eb5d72da6daab50d650f6733d1bd9668bed9af802e30',
        i686: 'e61ae07f85f64f0c53fa922714ac30579c77db5f2e9fa266e4e6059b502f5475',
      x86_64: '7a782fdba9f89b077004dab99c15367bb999ed1b19485e32a22be2e79c4f3ac3',
  })

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
