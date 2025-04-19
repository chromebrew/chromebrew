require 'package'

class Act < Package
  description 'Run your GitHub Actions locally'
  homepage 'https://github.com/nektos/act'
  version '0.2.76'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
     armv7l: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_armv7.tar.gz",
       i686: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_i386.tar.gz",
     x86_64: "https://github.com/nektos/act/releases/download/v#{version}/act_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '15adf3c7c1353fbd4bf11f7b66f133160557e9875a85fe33238609be43f48d9c',
     armv7l: '15adf3c7c1353fbd4bf11f7b66f133160557e9875a85fe33238609be43f48d9c',
       i686: '43f686cfa3edb33fedd0fe3167bbf605bb187de5ab7bb8df1205721cef5953d8',
     x86_64: 'd4720e05e73ce634239fc0e7fa6b552f9ac79b4e6c878a8756bbfacce3c56720'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'act', "#{CREW_DEST_PREFIX}/bin/act", mode: 0o755
  end
end
