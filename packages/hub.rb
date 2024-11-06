require 'package'

class Hub < Package
  description 'hub is a command-line wrapper for git that makes you better at GitHub.'
  homepage 'https://hub.github.com/'
  version '2.14.2'
  license 'MIT'
  compatibility 'all'
  source_url "https://github.com/github/hub/archive/refs/tags/v#{version}.tar.gz"
  source_sha256 'e19e0fdfd1c69c401e1c24dd2d4ecf3fd9044aa4bd3f8d6fd942ed1b2b2ad21a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '1f1b9adacc34fc75c35fb4789b929dba0361bb8f66910c2ff1e5e580fd02d97a',
     armv7l: '1f1b9adacc34fc75c35fb4789b929dba0361bb8f66910c2ff1e5e580fd02d97a',
       i686: '0f0f1901d1c73e998e17abcab8a6bf69b8494ae8b2f0d14556abd33b59f5efd6',
     x86_64: 'c1720760d44e772419129c0ae27cbdab8b9e8c29c7e578990dc38015b69081c2'
  })

  depends_on 'go' => :build

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system "script/build -o #{CREW_DEST_PREFIX}/bin/hub"
  end
end
