require 'package'

class Axel < Package
  description 'Light command line download accelerator for Linux and Unix'
  homepage 'https://github.com/axel-download-accelerator/axel'
  version '2.17.6'
  compatibility 'all'
  source_url 'https://github.com/axel-download-accelerator/axel/releases/download/v2.17.6/axel-2.17.6.tar.xz'
  source_sha256 '24ab549021bdfca01ad5e8e95b706869dd30fe9ab1043da4cbb9dff89edc267d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.17.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.17.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.17.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/axel-2.17.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31800a542f21b117b5bb78b8c7c62fdc38d2afac61d306ddac01d71569909f4a',
     armv7l: '31800a542f21b117b5bb78b8c7c62fdc38d2afac61d306ddac01d71569909f4a',
       i686: '804815af38ee5ba38ac407831e8e3e40adcc0cdca91fe770c76a47f02fd3cdc8',
     x86_64: '731b9413dee20493cfdeee3d8ed8b9379981aec08522677fdea16503e4ee90f0',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
