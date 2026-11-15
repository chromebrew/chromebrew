require 'buildsystems/cmake'

class Oorexx < CMake
  description 'Free implementation of Object Rexx'
  homepage 'https://www.oorexx.org/'
  version '5.2.0-13156'
  license 'CPL-v1.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/oorexx/oorexx/#{version.split('-')[0]}/oorexx-#{version}.tar.gz"
  source_sha256 'e69a6d18f49c5097d8cdec628be2c838b890310ca617587630f532349871ea21'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f3d88a35d96652f46fbd66a2694ee372c307bba3a26957e691fe23e842c7342',
     armv7l: '2f3d88a35d96652f46fbd66a2694ee372c307bba3a26957e691fe23e842c7342',
     x86_64: '6924c983ef0d13b6d31067c694cd209b460da18f2753ddedb134aa42a847e0a3'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxcrypt' => :library
  depends_on 'ncurses' => :library
  depends_on 'subversion' => :build
end
