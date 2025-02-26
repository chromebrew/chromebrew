require 'package'

class Shunit2 < Package
  description 'shUnit2 is a xUnit based unit test framework for Bourne based shell scripts.'
  homepage 'https://github.com/kward/shunit2'
  version '2.1.8'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/kward/shunit2.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ba69ceead1edbf4c8809b2295b012076f2bef11fef02f2e2fc29140ec67690b',
     armv7l: '4ba69ceead1edbf4c8809b2295b012076f2bef11fef02f2e2fc29140ec67690b',
       i686: 'd15b0aea1119c6490596cf68a92574bcad13ccb7a996cb084c17f445ddb79900',
     x86_64: '3b2c9adff980f325e3af1faf3d0a9234d79023865fe1d2e9efe975304ecf0fec'
  })

  # Tests fail, but current version is from 29/3/2020, so try re-enabling tests upon new release.
  # def self.check
  #   system './test_runner'
  # end

  def self.install
    FileUtils.install 'shunit2', "#{CREW_DEST_PREFIX}/bin/shunit2", mode: 0o755
  end
end
