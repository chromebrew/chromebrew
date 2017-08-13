require 'package'

class Git_lfs < Package
  description 'Git extension for versioning large files'
  homepage 'https://git-lfs.github.com/'
  version '2.2.1'
  source_url 'https://github.com/git-lfs/git-lfs/archive/v2.2.1.tar.gz'
  source_sha256 'fede2b31b0539fd4a580f831867caac1b5d5dc4405e938c4ee0bfeacfb78ad7a'

  depends_on 'go'

  def self.build
    system 'script/bootstrap'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
