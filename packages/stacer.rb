require 'buildsystems/cmake'

class Stacer < CMake
  description 'Stacer is an open source system optimizer and application monitor'
  homepage 'https://oguzhaninan.github.io/Stacer-Web/'
  version '1.1.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/oguzhaninan/Stacer.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b2082c9b0e5ce81d31ac06025abc6ff64d30b447fb498b01864880d1d78fd11',
     armv7l: '8b2082c9b0e5ce81d31ac06025abc6ff64d30b447fb498b01864880d1d78fd11',
     x86_64: '9c55ae8c8606e8b6ffd89249dcf2db3ef12232ced6cd9751c753fbbba2373f9c'
  })

  depends_on 'qt5_base' => :executable
  depends_on 'qt5_charts' => :executable
  depends_on 'qt5_svg' => :executable
  depends_on 'qt5_tools'

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/stacer")
  end

  no_lto # The lto build fails with '/bin/sh: 1: -flto: not found', oddly enough.
  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
