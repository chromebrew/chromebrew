require 'buildsystems/autotools'

class Apg < Autotools
  description 'APG (Automated Password Generator) is a toolset for random password generation.'
  homepage 'https://github.com/wilx/apg'
  version '2.3.0b-dcddc65'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/wilx/apg.git'
  git_hashtag 'dcddc65648f8b71ba8b9a9c1946034badb4ae7f3'
  # git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89bcf52ad78e2ee3853ef09f738cd3c5b9ba3345741a66ed28d64ef994dcf1c7',
     armv7l: '89bcf52ad78e2ee3853ef09f738cd3c5b9ba3345741a66ed28d64ef994dcf1c7',
       i686: '2607cbceedf2806bc73ec039fe27d9d6551a8b18d844487be4b5116ba3cb1d5e',
     x86_64: 'dd6c364cd1e9a7d7b5ce31be871315dcd2d014809235b916ad6cfc78734699e3'
  })

  def self.prebuild
    system 'autoreconf -fiv'
  end
end
