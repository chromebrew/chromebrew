require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.85'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'ca8723add4b0083be539a48a705f262b0333c8d7ec0e8602c53b0832a4b8a591',
     armv7l: 'ca8723add4b0083be539a48a705f262b0333c8d7ec0e8602c53b0832a4b8a591',
       i686: '1b15eed2402ad3b8dc0ee0882c045a775f83179aa523f14d72918efd8b42bc08',
     x86_64: 'fbf411fb5a47bff407d3be1f320f3314af050d92b0e7e9615075222ba0c22947'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
