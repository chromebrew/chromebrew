require 'package'

class Pdm < Package
  description 'Python Development Master (aka PDM) is a modern Python package manager with PEP 582 support.'
  homepage 'https://pdm.fming.dev/'
  version '2.28.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pdm-project/pdm.git'
  git_hashtag version

  no_compile_needed
  print_source_bashrc

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
