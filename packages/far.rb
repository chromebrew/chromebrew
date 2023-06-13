require 'package'

class Far < Package
  description 'Search and replace operations on file content across multiple files.'
  homepage 'http://findandreplace.sourceforge.net'
  version '2.0.3'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/findandreplace/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz'
  source_sha256 'd0e8406b08833be398476e3482a657998cd89e429025989f87cd35added5bedf'

  depends_on 'openjdk8'
  depends_on 'sommelier'

  no_compile_needed

  def self.build
    @far = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/far
      ./far.sh "$@"
    EOF
    File.write('far', @far)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/far"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/far"
    FileUtils.install 'far', "#{CREW_DEST_PREFIX}/bin/far", mode: 0o755
  end
end
