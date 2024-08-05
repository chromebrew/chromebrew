require 'buildsystems/cmake'

class Fetch < CMake
  description 'FreeBSD Fetch retrieves files by URL.'
  homepage 'https://github.com/jrmarino/fetch-freebsd'
  version '12.0.11'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/jrmarino/fetch-freebsd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41075f997abd150a9b45550c189366757304c1604ebbf50154ecf6b9d76474dc',
     armv7l: '41075f997abd150a9b45550c189366757304c1604ebbf50154ecf6b9d76474dc',
       i686: '2a88b20b8fddddab48017a39bb7087c5858e803433d1749b38bbcc77df82d34f',
     x86_64: '62999f08847a7a9c51fcfa70abb595906553ed8eb8fa75c2b11e67baa639b57c'
  })

  depends_on 'openssl'

  def self.patch
    Downloader.download 'https://patch-diff.githubusercontent.com/raw/jrmarino/fetch-freebsd/pull/6.patch', 'd872cae4f979c563be3659657a323ce444a469167733712a2e96f578ff9d7427'
    system 'git apply 6.patch'
  end

  cmake_options '-DFETCH_LIBRARY=ON -DUSE_SYSTEM_SSL=ON'
end
