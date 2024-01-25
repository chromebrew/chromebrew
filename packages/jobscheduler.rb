require 'package'

class Jobscheduler < Package
  description 'The JobScheduler is an Open Source solution for enterprise level workload automation.'
  homepage 'https://www.sos-berlin.com/jobscheduler'
  version '1.12.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/jobscheduler/jobscheduler_unix_universal_agent.1.12.3.tar.gz'
  source_sha256 '079819463d1e64300fd4f2231e84a62d282b4319dd5585fcbf6ca6014484352b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '91e009c4f9fdc0f8db00a71419235175e9ba0971a1511723866bad0358bc4429',
     armv7l: '91e009c4f9fdc0f8db00a71419235175e9ba0971a1511723866bad0358bc4429',
       i686: 'dacdfabdfc6066682963f04acd368bc65d71698d1d00337a859f90037c560f31',
     x86_64: 'b103672e6f0fbfe82ce2f81de472df9d607cf69bb2110d4c4b8265e1f9aa189b'
  })

  depends_on 'jdk8'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/ #{CREW_DEST_PREFIX}"
    system "cp -r var_4445/ #{CREW_DEST_PREFIX}"
  end

  def self.postinstall
    puts
    puts 'For usage information, see https://kb.sos-berlin.com/x/kQiX#JobSchedulerUniversalAgent-Installation&Operation-Usage'.lightblue
    puts
  end
end
