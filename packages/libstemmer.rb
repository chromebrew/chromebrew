require 'package'

class Libstemmer < Package
  description 'Snowball Stemming Algorithms'
  homepage 'https://snowballstem.org/'
  version '2.2.0'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/snowballstem/snowball.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d882999ed5e010b974e3abb6023619ba7a879351ec8f5b6cd830f4988042cf1',
     armv7l: '2d882999ed5e010b974e3abb6023619ba7a879351ec8f5b6cd830f4988042cf1',
       i686: '2b1c100854db9c1030182f9e5bf02182152b5826c719509b0bb9587f8181a297',
     x86_64: '9f5b021924d96941bc8ac9a93ecb56d06b4d4ee5cd6707eaeb98f51a5fe4bce7'
  })

  # https://github.com/snowballstem/snowball/issues/34
  def self.patch
    # [PATCH] update of #42 used to package for alpine linux
    downloader 'https://patch-diff.githubusercontent.com/raw/snowballstem/snowball/pull/160.patch', '141e1251c10d3d2b7d668415abcc5c90662e5415921355c8a5b9916fb1ec00ba'
    system 'git apply 160.patch'
  end

  def self.build
    system 'make'
  end

  # https://github.com/snowballstem/snowball/issues/189
  def self.install
    FileUtils.install 'include/libstemmer.h', "#{CREW_DEST_PREFIX}/include/libstemmer.h", mode: 0o644
    FileUtils.install %w[libstemmer.so libstemmer.so.2 libstemmer.so.2.2.0], CREW_DEST_LIB_PREFIX, mode: 0o644
  end
end
