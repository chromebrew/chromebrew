require 'buildsystems/cmake'

class Bdwgc < CMake
  description 'The Boehm-Demers-Weiser conservative C/C++ Garbage Collector'
  homepage 'https://www.hboehm.info/gc/'
  version '8.2.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/ivmai/bdwgc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '718039b9304be3d6f1e95b39bf273616f78001395dc122c0c5d99d602b688cba',
     armv7l: '718039b9304be3d6f1e95b39bf273616f78001395dc122c0c5d99d602b688cba',
       i686: 'a45f6d5cddd25d401994434a78ea55b627ee9a535950f68a8bff9549b932ff48',
     x86_64: 'a77db32c99ca663a23675e7c8562aee8fbfd58834ad235a84de4cdbef0f8dcf2'
  })

  depends_on 'glibc' # R
end
