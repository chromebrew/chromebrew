require 'package'

class Bazelisk < Package
  description 'A user-friendly launcher for Bazel.'
  homepage 'https://github.com/bazelbuild/bazelisk'
  version '1.27.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/bazelbuild/bazelisk.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '83d12d217865a03e4b84175a69f41a714a3c50234be2daea76757531e70bccfa',
     armv7l: '83d12d217865a03e4b84175a69f41a714a3c50234be2daea76757531e70bccfa',
       i686: '1ff2abd466f61d40aa8d753905189249b439043a8d51c697d63a39b8401e9714',
     x86_64: 'aae4e2b4ac92914362d0bb989631e09f585e53e25f8cb22e1055183a8818e561'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.build
    system 'go build -o bin/bazelisk'
  end

  def self.install
    FileUtils.install 'bin/bazelisk', "#{CREW_DEST_PREFIX}/bin/bazelisk", mode: 0o755
  end
end
