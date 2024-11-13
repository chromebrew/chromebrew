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
     x86_64: 'c3baac781ae26606f9366015d1edd4efa070e910718786a515aa5ad8c67d077d'
  })

  depends_on 'go' => :build

  def self.install
    system 'go', 'build',
      '-o', "#{CREW_DEST_PREFIX}/bin/elvish",
      '-trimpath',
      '-ldflags', '-s -w -X src.elv.sh/pkg/buildinfo.VersionSuffix=',
      './cmd/elvish'
  end
end
