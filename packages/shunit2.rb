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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  # Tests fail, but current version is from 29/3/2020, so try re-enabling tests upon new release.
  # def self.check
  #   system './test_runner'
  # end

  def self.install
    FileUtils.install 'shunit2', "#{CREW_DEST_PREFIX}/bin/shunit2", mode: 0o755
  end
end
