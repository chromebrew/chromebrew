require 'package'

class Libmrss < Package
  description 'libmRSS is a C library for parsing, writing and creating RSS files or streams.'
  homepage 'https://www.autistici.org/bakunin/libmrss/doc/'
  version '0.19.2-7'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/libmrss/-/archive/debian/0.19.2-7/libmrss-debian-0.19.2-7.tar.bz2'
  source_sha256 'cc3b466fa376d9fa54644268957437ce525fc336926180fda4e831af019767a6'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmrss/0.19.2-7_armv7l/libmrss-0.19.2-7-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmrss/0.19.2-7_armv7l/libmrss-0.19.2-7-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmrss/0.19.2-7_i686/libmrss-0.19.2-7-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmrss/0.19.2-7_x86_64/libmrss-0.19.2-7-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8536ff6ee637e13f466d73afcf6806e01742df9d8ffff07120bd03fc892728a4',
     armv7l: '8536ff6ee637e13f466d73afcf6806e01742df9d8ffff07120bd03fc892728a4',
       i686: '6b02273108a01956e372f18f57dcc93993d42c9c769adc1fa22971e07a105f2f',
     x86_64: '0a5dac52ae57e3fc9d86177dfd2480bc82293d74abe5b442f871b35fa8ff4665'
  })

  depends_on 'libnxml'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
