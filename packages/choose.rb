require 'package'

class Choose < Package
  description 'make choices on the command line'
  homepage 'https://github.com/geier/choose/'
  @_ver = '0.1.0'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/geier/choose.git'
  git_hashtag 'v' + @_ver

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/choose/0.1.0-1_armv7l/choose-0.1.0-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/choose/0.1.0-1_armv7l/choose-0.1.0-1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/choose/0.1.0-1_x86_64/choose-0.1.0-1-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: 'f3ec08baab32511620507363a34d626fa84c38f8d4bd97ea5555a60277207238',
     armv7l: 'f3ec08baab32511620507363a34d626fa84c38f8d4bd97ea5555a60277207238',
     x86_64: 'f2f8f6749ad11044fea2c920cc54978fb4f89c98aeeb1d70162f0e24e1630d3d',
  })

  depends_on 'py3_urwid'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "sed -i 's:#!/usr/bin/env python:#!#{CREW_PREFIX}/bin/python3:' choose"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.install "choose", "#{CREW_DEST_PREFIX}/bin/choose", mode: 0755, verbose: true
  end
end
