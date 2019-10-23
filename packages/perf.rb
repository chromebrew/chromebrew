require 'package'

class Perf < Package
  description 'Linux profiling with performance counters'
  homepage 'https://perf.wiki.kernel.org/index.php/Main_Page'
  version '4.14'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

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
