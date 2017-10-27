require 'package'

class Micro < Package
  description 'A modern and intuitive terminal-based text editor'
  homepage 'https://micro-editor.github.io/'
  version '1.3.3'

  case ARCH
  when 'aarch64'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.3.3/micro-1.3.3-linux-arm.tar.gz'
    source_sha256 '1d6ce6042b13fa19ecbae8b5a4d11b9e8d21b44f3720110993f62014199cd34c'
  when 'armv7l'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.3.3/micro-1.3.3-linux-arm.tar.gz'
    source_sha256 '1d6ce6042b13fa19ecbae8b5a4d11b9e8d21b44f3720110993f62014199cd34c'
  when 'i686'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.3.3/micro-1.3.3-linux32.tar.gz'
    source_sha256 '7600666ae08a878c40efa2448fce03a042a18132a2a7f27e134502d36065193d'
  when 'x86_64'
    source_url 'https://github.com/zyedidia/micro/releases/download/v1.3.3/micro-1.3.3-linux64.tar.gz'
    source_sha256 '329f746e4ee9edf244618dda4208b638fda34c593d5cd96d8f71dc3b53e3d994'
  end

  def self.install
    system "install -Dm755 micro #{CREW_DEST_PREFIX}/bin/micro"
  end
end
