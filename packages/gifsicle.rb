require 'buildsystems/autotools'

class Gifsicle < Autotools
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.95'
  license 'GPL-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/kohler/gifsicle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b408cd75c80c180c68265617e77e795fb74232c379b2fe70576edb0186b4166f',
     armv7l: 'b408cd75c80c180c68265617e77e795fb74232c379b2fe70576edb0186b4166f',
       i686: '5a81d9d1719b248848c189045f70dda0664ce01aa04604daadb20f0c9aab76b3',
     x86_64: '6fc9976eb9f4680a3a3b57adefc027f0b53b27e5186aea1d3e824509e4244c92'
  })

  configure_options '--without-x --disable-gifview'

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' test/testie"
  end

  def self.prebuild
    system './bootstrap.sh'
  end

  run_tests
end
