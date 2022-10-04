require 'package'

class Ninja < Package
  description 'a small build system with a focus on speed'
  homepage 'https://ninja-build.org'
  @_ver = '1.11.1'
  version "#{@_ver}-1"
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/ninja-build/ninja.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1-1_armv7l/ninja-1.11.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1-1_armv7l/ninja-1.11.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1-1_i686/ninja-1.11.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ninja/1.11.1-1_x86_64/ninja-1.11.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e3e130403a43980cc2ef0a03adb9156a6dbd31b5718efb445681a2191dbc2b2a',
     armv7l: 'e3e130403a43980cc2ef0a03adb9156a6dbd31b5718efb445681a2191dbc2b2a',
       i686: '190004a05d176d485eb3f0919fef7baac98d5d78f571160022558aabdec1d6bf',
     x86_64: '6ed13fed4d9f7332ce42b48e1da9411f0b9928ec9effb1d30817e342f5ef45d8'
  })

  depends_on 're2c' => :build
  depends_on 'samurai' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake \
          #{CREW_CMAKE_OPTIONS} \
          -Wdev \
          -G Ninja \
          .."
      system 'mold -run samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
