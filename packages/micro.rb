require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '2.0.13'
  license 'MIT'
  compatibility 'all'
  binary_compression 'tar.zst'
  
  no_compile_needed

  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux-arm.tar.gz'
    source_sha256 'adb9cf644354a5c85819db40e1a427f0f4951b172597bbcd3ef94ecc4a8c4b75'
  when 'i686'
    source_url 'https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux32.tar.gz'
    source_sha256 'd72d511b4f0fec5bb614b38607e68c5f0918f836d0f60e87c48f0b18e2eab916'
  when 'x86_64'
    source_url 'https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux64.tar.gz'
    source_sha256 'e7d4c9427f9fdfed78e69d42cf518e93ae15fc8f70b7f0f87d292ed81206e900'
  end

  def self.install
    system "install -Dm755 micro #{CREW_DEST_PREFIX}/bin/micro"
  end
end
