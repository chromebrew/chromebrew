require 'buildsystems/autotools'

class Gperf < Autotools
  description 'GNU gperf is a perfect hash function generator.'
  homepage 'https://www.gnu.org/software/gperf/'
  version '3.1-97c1fbc'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/gperf.git'
  git_hashtag '97c1fbcc8cc00c3a56af8be8543dedc588aace0f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49b1152ce33b46afac2e25a656d28e1304283a6e3c847662dbdd80ad58cecf90',
     armv7l: '49b1152ce33b46afac2e25a656d28e1304283a6e3c847662dbdd80ad58cecf90',
       i686: '04ae0d6f0337cbc88935e2909074699461bf48534811b9a4b6cb22c2caa13614',
     x86_64: 'e3876dc56fa7d9a23f2a91a15078f242f282da6f6178082e9d393a2002355d38'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'wget2' => :build

  def self.patch
    # Documentation requires texlive, our package for which is currently not working on certain architectures or glibc versions.
    system "sed -i '/gperf.texi/d' configure.ac"
    system "sed -i 's,tests doc],tests],' configure.ac"
    system "cat configure.ac | tac | sed '/doc/,+2d' | tac > configure.ac.new && mv configure.ac.new configure.ac"
    # For whatever reason, gperf doesn't actually support the usual `./autogen.sh && ./configure && make` build setup.
    system './autopull.sh'
  end
end
