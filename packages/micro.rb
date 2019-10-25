require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '1.4.1'

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.4.1/micro-1.4.1-linux-arm.tar.gz'
    source_sha256 '3d7a2d1df344fbf0d3bd76f6a6748e490d80c8dfd5f9e8539b25997d459c5411'
  when 'i686'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.4.1/micro-1.4.1-linux32.tar.gz'
    source_sha256 'd72d511b4f0fec5bb614b38607e68c5f0918f836d0f60e87c48f0b18e2eab916'
  when 'x86_64'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.4.1/micro-1.4.1-linux64.tar.gz'
    source_sha256 'e7d4c9427f9fdfed78e69d42cf518e93ae15fc8f70b7f0f87d292ed81206e900'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 micro #{CREW_DEST_PREFIX}/bin/micro"
  end
end
