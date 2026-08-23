require 'buildsystems/cmake'

class Vidstab < CMake
  description 'Transcode video stabilization plugin.'
  homepage 'http://public.hronopik.de/vid.stab/'
  version '1.1.2'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/georgmartius/vid.stab.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db0cfcdea3641fc8883ba6de616379297ac76c81c0ddddd5a630c3a4aa2b0f78',
     armv7l: 'db0cfcdea3641fc8883ba6de616379297ac76c81c0ddddd5a630c3a4aa2b0f78',
       i686: '5961d2fdde5156103d08c9fb51a3330eaf4cf8b22503a9559979049cbfdd37bb',
     x86_64: 'b2ff3858190a14761a8d2cdcd3146a2c099111f315900cb5989d277827f17d5f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
