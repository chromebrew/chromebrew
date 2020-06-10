require 'package'

class Dub < Package
  description 'Developer package manager for D programming language'
  homepage 'https://github.com/D-Programming-Language/dub'
  version '1.7.1'
  compatibility 'all'
  source_url 'https://github.com/dlang/dub/archive/v1.7.1.tar.gz'
  source_sha256 'baa8c533f59d83f74e89c06f5ec7e52daf3becb227c7177a9eeab7159ba86dbc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dub-1.7.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dub-1.7.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dub-1.7.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dub-1.7.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fc18b55caf6bf1b72d4400727be146fb0dc55978d8157976b7058b03928d1312',
     armv7l: 'fc18b55caf6bf1b72d4400727be146fb0dc55978d8157976b7058b03928d1312',
       i686: 'fbfbe69630730c275192a1c5c953402486b16573090f0fb7c17661d221b455ec',
     x86_64: '7213094cd902a3f201be78d692075782d2b78ac72af5df34248cddc203443270',
  })

  depends_on 'ldc'

  def self.build
    system "echo \"module dub.version_;\" > source/dub/version_.d"
    system "echo 'enum dubVersion = \"1.7.1\";' >> source/dub/version_.d"
    system "ldmd2 -ofbin/dub -w -O -g -version=DubUseCurl -Isource -L-lcurl @build-files.txt"
  end

  def self.install
    system "install", "-Dm755",  "bin/dub", "#{CREW_DEST_PREFIX}/bin/dub"
  end
end
