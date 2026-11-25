require 'buildsystems/autotools'

class Gifsicle < Autotools
  description 'Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations.'
  homepage 'http://www.lcdf.org/gifsicle/'
  version '1.99'
  license 'GPL-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/kohler/gifsicle.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'df1f46189800075c96828cd489e123b41633ac93aa3db41053dd0c1f7e555367',
     armv7l: 'df1f46189800075c96828cd489e123b41633ac93aa3db41053dd0c1f7e555367',
       i686: '082df673c3073e400976ca1a1bfd44ba6a7cb0a127e521d0decaf49c41b7952f',
     x86_64: 'ddeac5afef8d4f0d5b97cefb745efe837f5fd684b752d61b71ad8f992bf4d3f8'
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
