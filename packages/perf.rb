require 'package'

class Perf < Package
  description 'Linux profiling with performance counters'
  homepage 'https://perf.wiki.kernel.org/index.php/Main_Page'
  version '4.14'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/perf-4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/perf-4.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/perf-4.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/perf-4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '87c533c2b45a9beec0ef975b4a3f110e42a6d03def1820dfd3190fb3f767e710',
     armv7l: '87c533c2b45a9beec0ef975b4a3f110e42a6d03def1820dfd3190fb3f767e710',
       i686: '9786bce0863320385c3dd96534c681e5eae26d593851bde4278d30aa4dedec22',
     x86_64: '95e550bc751bd655a0d885104ec0f88aad533b8450af35438802f0a848b768be',
  })

  # Reuse linux sources if they're already installed
  depends_on 'linux_sources' => :build

  def self.build
    Dir.chdir("#{CREW_PREFIX}/src/linux/tools/perf") do
      system "make WERROR=0 prefix=#{CREW_PREFIX}"
    end
  end

  def self.install
    Dir.chdir("#{CREW_PREFIX}/src/linux/tools/perf") do
      system 'make',
             'WERROR=0',
             'missing_tools=xmlto', # Docs are broken, disable
             "prefix=#{CREW_PREFIX}",
             "DESTDIR=#{CREW_DEST_DIR}",
             'install'
    end
  end
end
