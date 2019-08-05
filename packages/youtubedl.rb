require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2019.08.02'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2019.08.02.tar.gz'
  source_sha256 '0c8e936d8212de803d1748aacd7559a6a91eb547de75c362c15db6cae4abcea1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.08.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.08.02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.08.02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.08.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0524e079c9640b06bfdc3be2b2b626055d49f2931a7446fc37016a3b846c7db9',
     armv7l: '0524e079c9640b06bfdc3be2b2b626055d49f2931a7446fc37016a3b846c7db9',
       i686: '7581c47d198824590b586968df3f9ad20852f67548673800c95b7c9df8a0c0dc',
     x86_64: '202f60aa6b718a9e0ba2272cea0332c4d4110dd093d80ccf1b1590ac78454168',
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
