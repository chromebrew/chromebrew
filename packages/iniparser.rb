require 'buildsystems/cmake'

class Iniparser < CMake
  description 'stand-alone ini parser library in ANSI C'
  homepage 'http://ndevilla.free.fr/iniparser/'
  version '4.3.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ndevilla/iniparser.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '703c5d2acff44a6e89fa393ba6eaf47b4b1926cd003b44b4915268bb89c4cd1c',
     armv7l: '703c5d2acff44a6e89fa393ba6eaf47b4b1926cd003b44b4915268bb89c4cd1c',
       i686: 'f05f9d9ffa66b270f88e029dfd7729e2a2340750ee9466c011df44f77834da14',
     x86_64: '86c9c34d5a9e7cf563c48bc23febbf6116f67aab9f3fe0b68de8151d4cf6973d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
