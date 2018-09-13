require 'package'

class Pandoc < Package
  description 'Universal markup converter'
  homepage 'https://github.com/jgm/pandoc/'
  version '2.2.1'
  
  source_url 'https://github.com/jgm/pandoc/releases/download/2.2.1/pandoc-2.2.1-linux.tar.gz'
  source_sha256 '3b1b573cdf957b4102c42ce6f5a641787267a55a5e88dcca942fd471c25793cb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/pandoc-2.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '878badef0e0f83923cfaa342f07af0df7e5c8bd5bf035315349bd4a057ed864e',
     armv7l: '878badef0e0f83923cfaa342f07af0df7e5c8bd5bf035315349bd4a057ed864e',
       i686: '57d09f7f0d47143fac22322dafa0cc8f5de100be95f6f1eff677d136405ea842',
     x86_64: 'd1f7f66ff580870e815178a4b7bcd7848444268a6a904db2829a5b8891b8b2ee',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r share/ #{CREW_DEST_PREFIX}"
  end
end
