require 'package'

class Utf8proc < Package
  description 'a clean C library for processing UTF-8 Unicode data: normalization, case-folding, graphemes, and more'
  homepage 'https://julialang.org/utf8proc/'
  version '2.7.0'
  license 'MIT and custom'
  compatibility 'all'
  source_url 'https://github.com/JuliaStrings/utf8proc.git'
  git_hashtag "v#{version}"
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/utf8proc/2.7.0_armv7l/utf8proc-2.7.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/utf8proc/2.7.0_armv7l/utf8proc-2.7.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/utf8proc/2.7.0_i686/utf8proc-2.7.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/utf8proc/2.7.0_x86_64/utf8proc-2.7.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e39494e5757c24266a70ce9ed250f586e7fe1e6afc57986073cc783f70fe5780',
     armv7l: 'e39494e5757c24266a70ce9ed250f586e7fe1e6afc57986073cc783f70fe5780',
       i686: '23750d9ea1dee537670e2b5d81a59fa972d30286a2402703af0850510011dfb1',
     x86_64: '7a3c31040fb2dcdafdd1de5e7b3c61a4aeb77c38dc59ecb10138fe205da858d3'
  })

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DUTF8PROC_ENABLE_TESTING=ON .."
      system 'samu'
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
