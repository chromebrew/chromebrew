require "package"

class Mywanip < Package
  description 'Script to grab your WAN IP address using various means.'
  homepage 'https://gist.github.com/DennisLfromGA/ab40940d37be84ae3a88'
  version 'ab4094'
  compatibility 'all'
  source_url 'https://gist.github.com/DennisLfromGA/ab40940d37be84ae3a88/archive/b583835e8b2cb7edefc7ccbb911cb8eaf172d341.zip'
  source_sha256 '789d22cfa60a40cf60d59e561500cd27e39ac03ecff2e948111a2a07f830fd67'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mywanip-ab4094-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mywanip-ab4094-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mywanip-ab4094-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mywanip-ab4094-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '21449c16c8493278b97ca5a35252bcda7b0da5d0210649662ad64ff5945fc2d8',
     armv7l: '21449c16c8493278b97ca5a35252bcda7b0da5d0210649662ad64ff5945fc2d8',
       i686: '2268ba3b816879fdda663b148b129fe90a88ffa6c55e1665743f8a13e744b9ff',
     x86_64: 'fb4fae274c359179e78f22147202ec456ff829c45cda9536038952848d4b3a6a',
  })

  def self.install
    system "chmod +x mywanip"
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp mywanip #{CREW_DEST_PREFIX}/bin"
  end
end

