require 'package'

class Powerstat < Package
  description 'Powerstat measures the power consumption of a laptop using the ACPI battery information.'
  homepage 'http://kernel.ubuntu.com/~cking/powerstat/'
  version '0.02.22'
  compatibility 'all'
  source_url 'https://kernel.ubuntu.com/~cking/tarballs/powerstat/powerstat-0.02.22.tar.gz'
  source_sha256 'ef74e023353a24a0a52068a0e474041b9556bcef5b4fe41db44261afd32a6564'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/powerstat-0.02.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a80779c88fd6ba1d192530ce6fa281aad82237b3067f251815a2f2f2ad5aa51d',
     armv7l: 'a80779c88fd6ba1d192530ce6fa281aad82237b3067f251815a2f2f2ad5aa51d',
       i686: '2cf7b359839f8feedb8c41d976a196dfc0194edbc51e281e1ac7aa233e7974ad',
     x86_64: 'cf5f0e425a5b4a0bfbcf4e3747ccd4f5edcd6489ae0bbb9db873cec95ba30406',
  })

  def self.build
    system "sed -i 's,/usr,#{CREW_PREFIX},g' Makefile"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
