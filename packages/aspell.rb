require 'buildsystems/autotools'

class Aspell < Autotools
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.8.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/GNUAspell/aspell.git'
  git_hashtag "rel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fece185e11214ffa510e8e0a1514bbd3f9f07e6b6a22748da396f0d4f9667b15',
     armv7l: 'fece185e11214ffa510e8e0a1514bbd3f9f07e6b6a22748da396f0d4f9667b15',
       i686: '1c571f32aa978741033b54877ac0fc65437c14d52ee342e3ba28294ae2d76c36',
     x86_64: '0adb8aaa62679070ce285f3afde4a8a559bfa645b7c11b632771b9767f667abf'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ncurses' => :executable
end
