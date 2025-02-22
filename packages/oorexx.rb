require 'buildsystems/cmake'

class Oorexx < CMake
  description 'Free implementation of Object Rexx'
  homepage 'https://www.oorexx.org/'
  version '5.1.0-12932'
  license 'CPL-v1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/oorexx/oorexx/#{version.split('-')[0]}beta/oorexx-#{version}.tar.gz"
  source_sha256 'e69a6d18f49c5097d8cdec628be2c838b890310ca617587630f532349871ea21'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '309106ff3a457124ee1ef2a4b99893fd3f51502a456591b8e5b41ac1e3d6ef3d',
     armv7l: '309106ff3a457124ee1ef2a4b99893fd3f51502a456591b8e5b41ac1e3d6ef3d',
     x86_64: '7f74ddab696a9a15e3430cfa8459fdc07d716f7760ef8d9441c910ece658dd7c'
  })

  depends_on 'ncurses'
  depends_on 'subversion' => :build
end
