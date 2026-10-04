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
    aarch64: '7432b433a0d25e14f80a3f156d674a0a70c974cef5707888c8f42a47129ab6d3',
     armv7l: '7432b433a0d25e14f80a3f156d674a0a70c974cef5707888c8f42a47129ab6d3',
       i686: 'c99805a824c6e7a4b0567ea63f44f405b81206002b54adee7c9936657701bf24',
     x86_64: '4d28a6f1aeb507d031b7ac0211a34b4368cd650d41881327d361df0e6bd44b1a'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
