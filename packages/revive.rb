require 'package'

class Revive < Package
  description 'Faster, stricter, configurable, extensible, and beautiful drop-in replacement for golint'
  homepage 'https://github.com/mgechev/revive'
  version '1.5.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/mgechev/revive.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd274219f58ab1d934e84f8e55453722fa20c06ad4c5674151940f8ba78ab19c',
     armv7l: 'cd274219f58ab1d934e84f8e55453722fa20c06ad4c5674151940f8ba78ab19c',
       i686: '75cab2c565ade37ba378080ee6a15a60e1ba0bdafd99631eed102866b5220b2d',
     x86_64: '9161d1a77e0c5f25601ffc9363c7b6089dd6d24bee0c2377d5a5fb538b49c445'
  })

  depends_on 'go' => :build
  depends_on 'glibc' # R

  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "go build -o #{CREW_DEST_PREFIX}/bin/revive"
  end
end
