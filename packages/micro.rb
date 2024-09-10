require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '2.0.13'
  license 'MIT'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux-arm.tar.gz'
    source_sha256 'adb9cf644354a5c85819db40e1a427f0f4951b172597bbcd3ef94ecc4a8c4b75'
  when 'i686'
    source_url 'https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux32.tar.gz'
    source_sha256 'a711d7281152b2b578a7b91bca70fe6782ca3e317e99be640dbb6bb3eb5a2bcd'
  when 'x86_64'
    source_url 'https://github.com/zyedidia/micro/releases/download/v2.0.13/micro-2.0.13-linux64.tar.gz'
    source_sha256 'a50e405d3d09d58f6b2c182429c18537a05f317dc0c3c9cb834b3271362e4781'
  end

  no_compile_needed

  def self.install
    system "install -Dm755 micro #{CREW_DEST_PREFIX}/bin/micro"
  end
end
