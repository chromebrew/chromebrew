require 'package'

class Libvoamrwbenc < Package
  description 'Audio codecs extracted from Android Open Source Project.'
  homepage 'https://sourceforge.net/projects/opencore-amr/'
  version '0.1.3'
  source_url 'https://downloads.sourceforge.net/project/opencore-amr/vo-amrwbenc/vo-amrwbenc-0.1.3.tar.gz'
  source_sha256 '5652b391e0f0e296417b841b02987d3fd33e6c0af342c69542cbb016a71d9d4e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvoamrwbenc-0.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '040678660adea36c6657715ae7e83f1465d8c767dc012ab5fdd17ba2c2ac3e02',
     armv7l: '040678660adea36c6657715ae7e83f1465d8c767dc012ab5fdd17ba2c2ac3e02',
       i686: 'ce022c0cbcad5c07e7045a70a0716e947e46e20c0b200e1c252ed5fab4d25836',
     x86_64: 'be050034d188c1cce40d7340a73bb5dde2693cb4210e6c39f81b3848de197a0a',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
