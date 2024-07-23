require 'buildsystems/autotools'

class Gperf < Autotools
  description 'GNU gperf is a perfect hash function generator.'
  homepage 'https://www.gnu.org/software/gperf/'
  version '3.2-a02b465'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/gitweb/?p=gperf.git;a=snapshot;h=a02b4653ee52990b22ad887607dcb881e1625258;sf=tgz'
  source_sha256 '2a2634e8f04cd37f310eaa2c4736c18a21e06f435b91f66c9034a70e9d62fff9'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '856d1b4130417459b22d5da15eee2bd04b27d6d2e52a473a5ec7add736ef34be',
     armv7l: '856d1b4130417459b22d5da15eee2bd04b27d6d2e52a473a5ec7add736ef34be',
       i686: '095f630631ab8126d36cd655fa2db5049625bebae5e68bba8ac443af96c42955',
     x86_64: '7c0e8b3a2f12543adb7e5f3025c58d8059f7b98ec74529db76324e7dafa45ad6'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'wget2' => :build

  def self.patch
    system 'tar --strip-components=1 -xf gitweb'
    # doc generation requires newer tex from glibc 2.28...
    system "sed -i '/gperf.texi/d' configure.ac"
    system "sed -i 's,tests doc],tests],' configure.ac"
    system "cat configure.ac | tac | sed '/doc/,+2d' | tac > configure.ac.new && mv configure.ac.new configure.ac"
    system './autopull.sh'
  end
end
