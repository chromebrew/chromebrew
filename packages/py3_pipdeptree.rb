require 'buildsystems/pip'

class Py3_pipdeptree < Pip
  description 'Displays a dependency tree of the installed Python packages.'
  homepage 'https://github.com/naiquevin/pipdeptree/'
  version "4.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a3d132c3e6051b4c8dc3820f3e255727483994a351aeb12dde0e020a71fd457',
     armv7l: '2a3d132c3e6051b4c8dc3820f3e255727483994a351aeb12dde0e020a71fd457',
       i686: '952bcb2d0a91712701c08a5ecb5bf18ddafd336cee92ae97f89d50da84af1f25',
     x86_64: '535aef69e427ad4c65e79ac68507ea7ff962633ed51d77b291dc3ab42f0384cf'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
