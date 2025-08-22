require 'buildsystems/autotools'

class Bacon < Autotools
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'https://chiselapp.com/user/bacon/repository/bacon/home'
  version '5.0.1'
  license 'MIT'
  compatibility 'all'
  source_url "https://www.basic-converter.org/stable/bacon-#{version}.tar.gz"
  source_sha256 '7f0a6dd3a3d465dd414f165a319838f0691d44157bd034845694fa32649ab97b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7fb09aed952f9062229db822bf8703626c061fea5492764adfa5f955cac7828c',
     armv7l: '7fb09aed952f9062229db822bf8703626c061fea5492764adfa5f955cac7828c',
       i686: 'aaa886ad1cebf601dd1342c2acbe4d0fc28353ef5df2d54d8081d4af051e195c',
     x86_64: '252211ebb4a026d5e799bd9d39c7750e9d6fcd4b721dd951f38622f6ae3f0a6b'
  })

  depends_on 'glibc' # R

  def self.patch
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
  end

  autotools_configure_options '--disable-gui'
end
