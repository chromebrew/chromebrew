require 'buildsystems/autotools'

class Libmd < Autotools
  description 'libmd provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  version '1.3.0'
  license 'BSD-3, BSD-2, ISC, Beerware, public-domain'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libmd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e22d9680d6085483f4b07badd304fe181b3147b8e2102359fcbd8927cfde2f93',
     armv7l: 'e22d9680d6085483f4b07badd304fe181b3147b8e2102359fcbd8927cfde2f93',
       i686: '5a52f7c6db9fb0e122364a469fdecc7cbb185127de05073d7e4ca28c4c9e96cd',
     x86_64: '565cd542aadfcf364053a36b93899289b514a8e448df892214df00c35f1e6619'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
