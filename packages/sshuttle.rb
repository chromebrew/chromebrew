require 'package'

class Sshuttle < Package
  description 'Full-featured VPN over an SSH tunnel'
  homepage 'https://github.com/sshuttle/sshuttle'
  version '0.78.3'
  compatibility 'all'
  source_url 'https://github.com/sshuttle/sshuttle/archive/v0.78.3.tar.gz'
  source_sha256 '62c18b4d89e654687247a334e0ebaec675d38dfbedc6863d8d65044d37241b0f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sshuttle-0.78.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sshuttle-0.78.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sshuttle-0.78.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sshuttle-0.78.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fad069cad984ae9a16cfe2109aa5e4f1b4af1435a9fd99075fe363d65b201348',
     armv7l: 'fad069cad984ae9a16cfe2109aa5e4f1b4af1435a9fd99075fe363d65b201348',
       i686: '5ffe9107c4521deeda7a3923badad164b022bdaa9dcfa2b42b6a03577c1bfb26',
     x86_64: '190a0ae5caaf93289b624a7dacbbeb22bcba4c4987bedf5d04e5e7d65323f4fa',
  })

  def self.install
    system "pip3 install sshuttle --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
