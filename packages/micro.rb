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

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/micro-1.3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/micro-1.3.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/micro-1.3.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/micro-1.3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6522c21cd8861a6477172cfc59d84a2e0339c7ef935fbbdac9207dae8a204c80',
     armv7l: '6522c21cd8861a6477172cfc59d84a2e0339c7ef935fbbdac9207dae8a204c80',
       i686: '13579b24473499d0509932bb73bcb01ec2e1946e2d4012ee0698948b608d4bbf',
     x86_64: '36bfbe54a6971ccd4b33687904677b98c43cc29155949aa664ae1ea428a1fa2a',
  })

  def self.install
    system "install -Dm755 micro #{CREW_DEST_PREFIX}/bin/micro"
  end
end
