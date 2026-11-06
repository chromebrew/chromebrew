require 'buildsystems/autotools'

class Gifsicle < Autotools
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.98'
  license 'GPL-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/kohler/gifsicle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '31d5d89802d163d0d8dc2b8d19f8cec8d81dd2809662d29eec50fcf2d5ee20c0',
     armv7l: '31d5d89802d163d0d8dc2b8d19f8cec8d81dd2809662d29eec50fcf2d5ee20c0',
       i686: '82b7774bef387e6c88ef205f7b684ad1684ea5d91f944b628940ba1e73558711',
     x86_64: 'cff5953f3f3d6cd4d3e3f0b380dcdb9e96de649209a1a9e6ef59aa9afc814536'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_configure_options '--without-x --disable-gifview'

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' test/testie"
  end

  def self.prebuild
    system './bootstrap.sh'
  end

  run_tests
end
