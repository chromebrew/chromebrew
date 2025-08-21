require 'buildsystems/autotools'

class Gifsicle < Autotools
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.96'
  license 'GPL-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/kohler/gifsicle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af90dcab82de8d5bab592c5e5fa0eb0650d57ca6b7d8e270ed895cee85d8939a',
     armv7l: 'af90dcab82de8d5bab592c5e5fa0eb0650d57ca6b7d8e270ed895cee85d8939a',
       i686: '77965e8560f1fbfae8b0bb78a33b95bd6d2fd8dfba47d5cfcf49b1aa8a51f789',
     x86_64: '340648beaab00e5d33c7db52de43b46fe4b5037c8a538660107a68d04dde09bd'
  })

  depends_on 'glibc' # R

  autotools_configure_options '--without-x --disable-gifview'

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' test/testie"
  end

  def self.prebuild
    system './bootstrap.sh'
  end

  run_tests
end
