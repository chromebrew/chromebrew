require 'package'

class A2ps < Package
  description 'GNU a2ps is an Any to PostScript filter.'
  homepage 'http://www.gnu.org/software/a2ps/'
  version '4.14'
  source_url 'http://ftp.gnu.org/gnu/a2ps/a2ps-4.14.tar.gz'
  source_sha256 'f3ae8d3d4564a41b6e2a21f237d2f2b104f48108591e8b83497500182a3ab3a4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/a2ps-4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c388a6a5eff22947cf9736e2afb74076166667efb5e383521b7669323f8b3935',
     armv7l: 'c388a6a5eff22947cf9736e2afb74076166667efb5e383521b7669323f8b3935',
       i686: '41705706fd35654a82614f9765066ddad5c775c4874a680d00df9ec357c5e3a0',
     x86_64: 'f457623eac89e9b57b1784ff44016e4a53c224dbd0d3384a83d488e65cadd189',
  })

  depends_on 'gperf'
  depends_on 'filecmd'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end

