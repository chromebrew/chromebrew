require 'package'

class Autosetup < Package
  description 'autosetup is a tool, similar to autoconf, to configure a build system'
  homepage 'https://msteveb.github.io/autosetup/'
  version '0.7.3'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/msteveb/autosetup.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c8a0c9da4c2bbd06a39796f91803afaf938a5eb286173c78e693a3633cdf5f2',
     armv7l: '5c8a0c9da4c2bbd06a39796f91803afaf938a5eb286173c78e693a3633cdf5f2',
       i686: 'dfb6abd0ac98d58f1cb3def005eb7144a475b56c7906d707ff3984ca43e1d1b6',
     x86_64: '1778a8e1a12d29d8d56c920997ae31fe8987ec7097e9dc3200844ad86a338122'
  })

  depends_on 'tcl'

  def self.build
    system 'make'
  end

  def self.install
    system "./autosetup --sysinstall=#{CREW_DEST_PREFIX}"
  end
end
