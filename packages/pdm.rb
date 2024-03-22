require 'package'

class Pdm < Package
  description 'Python Development Master (aka PDM) is a modern Python package manager with PEP 582 support.'
  homepage 'https://pdm.fming.dev/'
  version '1.13.5'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pdm-project/pdm/archive/1.13.5.tar.gz'
  source_sha256 'f4bd4f52ee4311e370d29482217c0dd314d372eca0689e7e4d06795c08b20ee9'

  def self.install
    no_fhs
    system "python3 install-pdm.py --path #{CREW_DEST_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    system "#{CREW_DEST_PREFIX}/bin/pdm --pep582 > #{CREW_DEST_PREFIX}/etc/bash.d/pdm.pep582"
    system "#{CREW_DEST_PREFIX}/bin/pdm completion bash > #{CREW_DEST_PREFIX}/etc/bash.d/pdm.bash-completion"
    system "sed -i 's,#{CREW_DEST_DIR},,g' #{CREW_DEST_PREFIX}/etc/bash.d/pdm.pep582"
    FileUtils.ln_sf "#{CREW_PREFIX}/venv/bin/pdm", "#{CREW_DEST_PREFIX}/bin/pdm"
    Dir["#{CREW_DEST_PREFIX}/venv/bin/*"].each do |bin|
      system "sed -i 's,#{CREW_DEST_DIR},,g' #{bin}"
    end
  end
end
