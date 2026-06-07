require 'package'

class Gzsize < Package
  description 'Print the uncompressed size of a GZipped file.'
  homepage 'https://bfontaine.github.io/gzsize/'
  version '0.1.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/bfontaine/gzsize.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8add72675046e4794dc152997733bb28c3d82971ee9fbb53971356f3e61761f5',
     armv7l: '8add72675046e4794dc152997733bb28c3d82971ee9fbb53971356f3e61761f5',
       i686: 'f3ce17be0ac1514aa31ef28f8602ac60c4bdb9b5a2dca4537b14da0b53ce7e26',
     x86_64: '823ee25dfafac7fd9a24963f657713d9c84d1016d064fd3a26ba890f57005ea2'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'zlib' => :executable

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.install 'gzsize', "#{CREW_DEST_PREFIX}/bin/gzsize", mode: 0o755
    FileUtils.install 'man/gzsize.1', "#{CREW_DEST_PREFIX}/man/man1/gzsize.1", mode: 0o644
  end
end
