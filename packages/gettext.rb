require 'buildsystems/autotools'

class Gettext < Autotools
  description 'GNU gettext utilities are a set of tools that provides a framework to help other GNU packages produce multi-lingual messages.'
  homepage 'https://www.gnu.org/software/gettext/'
  version "0.25.1-a0e74b9-#{CREW_ICU_VER}"
  # version "0.25.1-#{CREW_ICU_VER}"
  license 'GPL-3+ and LGPL-2.1+'
  compatibility 'all'
  # source_url "https://ftp.gnu.org/pub/gnu/gettext/gettext-#{version.split('-')[0]}.tar.lz"
  # source_sha256 'c70678c88589ee48e55ae1f3843935afa4be1466fb1bc737658dc933f60379f5'
  source_url 'https://https.git.savannah.gnu.org/git/gettext.git'
  git_hashtag 'a0e74b95831bfa37e3f4293b307c25d584b536f7'
  # git_hashtag "v#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f86e40b77f046b86822f6d7bbcca8d5073657a20b10997ae874601dc5c0bb24',
     armv7l: '2f86e40b77f046b86822f6d7bbcca8d5073657a20b10997ae874601dc5c0bb24',
       i686: '606b3b9a62738e950dec90a644c8a5ba062c6cbf8f5d2869f79a12db165b83ea',
     x86_64: 'ef3bcbd7d97d02b964860b28bb008bf41900a5013c19a77c7f35caf8bc06189f'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'icu4c' # R
  depends_on 'libunistring' # R
  depends_on 'libxml2' # R
  depends_on 'ncurses' # R
  depends_on 'openjdk8' => :build
  depends_on 'wget2' => :build
  depends_on 'zlib' # R

  autotools_configure_options '--disable-static \
    --enable-shared \
    --with-pic \
    --without-included-gettext'

  def self.patch
    system './autopull.sh'
  end

  # cldr-plurals-1 test fails with icu75.1
  # run_tests
end
