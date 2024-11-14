require 'package'

class Elvish < Package
  description 'Friendly and expressive shell'
  homepage 'https://elv.sh/'
  version '0.21.0'
  license 'BSD-2-Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/elves/elvish.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'bd53118a35e0dbedeaaab0262ea847959c5693ab7208559d0a6748bbeb841cdb'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system 'go', 'build',
           '-o', "#{CREW_DEST_PREFIX}/bin/elvish",
           '-trimpath',
           '-ldflags', '-s -w -X src.elv.sh/pkg/buildinfo.VersionSuffix=',
           './cmd/elvish'
  end
end
