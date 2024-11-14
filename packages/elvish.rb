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
     x86_64: '4c25a1c9b97a78b30fcd843511deec3e1240ed2b0646f3007fc9d5ae508a3bf6'
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
