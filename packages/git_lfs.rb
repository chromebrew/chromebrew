require 'package'

class Git_lfs < Package
  description 'Git extension for versioning large files'
  homepage 'https://git-lfs.github.com/'
  version '2.2.1'
  compatibility 'all'
  source_url 'https://github.com/git-lfs/git-lfs/archive/v2.2.1.tar.gz'
  source_sha256 'fede2b31b0539fd4a580f831867caac1b5d5dc4405e938c4ee0bfeacfb78ad7a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/git_lfs-2.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/git_lfs-2.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/git_lfs-2.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/git_lfs-2.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b4b7371e813ca12a6c2261602c3e55f52d3b856869d65f2f7f20aa86762e130',
     armv7l: '7b4b7371e813ca12a6c2261602c3e55f52d3b856869d65f2f7f20aa86762e130',
       i686: '67fac00c8c74a5e7bd756b387275b9d33200de3e36474c5b29e91400745caad6',
     x86_64: '10a0ed5b9ec97692c89314d2fbfb38e173e23414d6724464b71a310db11c18be',
  })

  depends_on 'go'

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
    system 'script/bootstrap'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
  end
end
