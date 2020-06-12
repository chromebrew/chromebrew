require 'package'

class Inxi < Package
  description 'inxi is a full featured CLI system information tool.'
  homepage 'https://smxi.org/docs/inxi.htm'
  version '811a19'
  compatibility 'all'
  source_url 'https://github.com/smxi/inxi/archive/811a199badbacc8d54254264c51de8dc3f5c82d2.tar.gz'
  source_sha256 'fd4d7e89166f4cd96fe91448753a1279520bc0f9ee3a2cfbd92ff4a2b1cf487a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/inxi-811a19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/inxi-811a19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/inxi-811a19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/inxi-811a19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a7605cdd62c35259dddf00c133c7af00816ed270b3326094a129f9436e65700e',
     armv7l: 'a7605cdd62c35259dddf00c133c7af00816ed270b3326094a129f9436e65700e',
       i686: 'c8dc00fc15d1fd8b11386b71c061746361fc5792f7bbede5ecc3a244aaf8c357',
     x86_64: '6226f1fb5fbeb93ab9ad7237de9f1e8f21bba3e47e035f1b2776c4733972e197',
  })

  depends_on 'gawk'
  depends_on 'perl'

  def self.build
    system "sed -i 's,/os-release,/lsb-release,g' inxi"
  end

  def self.install
    system "install -Dm755 inxi #{CREW_DEST_PREFIX}/bin/inxi"
    system "install -Dm644 inxi.1.gz #{CREW_DEST_PREFIX}/man/man1/inxi.1.gz"
  end
end
