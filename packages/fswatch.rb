require 'buildsystems/autotools'

class Fswatch < Autotools
  description 'fswatch is a file change monitor that receives notifications when the contents of the specified files or directories are modified.'
  homepage 'https://github.com/emcrisostomo/fswatch'
  version '1.22.0'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.41'
  source_url 'https://github.com/emcrisostomo/fswatch.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef0fa24ca31966a0ca600cd5de2f9022c6617a61cb86b871e0a9f249b84b90c9',
     armv7l: 'ef0fa24ca31966a0ca600cd5de2f9022c6617a61cb86b871e0a9f249b84b90c9',
     x86_64: '5a433c84d52c51b36eaf4a05ad961408bf76cbfddab09ddf5eb404f32006c8e5'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  autotools_configure_options '--disable-static'

  run_tests
end
