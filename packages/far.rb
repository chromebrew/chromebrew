require 'package'

class Far < Package
  description 'Search and replace operations on file content across multiple files.'
  homepage 'http://findandreplace.sourceforge.net'
  version '2.0.2'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/findandreplace/findandreplace/2.0.2/FAR-2.0.2-x.tar.gz'
  source_sha256 '0b2c796bdcc088be960f15cb4e348f8af62f74afbdacc188c3c101c2f502204d'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.build
    system "echo '#!/bin/bash' > far"
    system "echo 'cd #{CREW_PREFIX}/share/far' >> far"
    system "echo './far.sh' >> far"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/far"
    system "cp -r . #{CREW_DEST_PREFIX}/share/far"
    system "install -Dm755 far #{CREW_DEST_PREFIX}/bin/far"
  end
end
