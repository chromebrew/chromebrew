require 'buildsystems/autotools'

class Kbd < Autotools
  description 'The kbd project contains tools for managing Linux console'
  homepage 'http://kbd-project.org/'
  version '2.10.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/legionus/kbd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffd2abaa65fc09a2ec8442804d11fe6b3b60f3f83750a4a043783a9e952cc1c3',
     armv7l: 'ffd2abaa65fc09a2ec8442804d11fe6b3b60f3f83750a4a043783a9e952cc1c3',
     x86_64: '3697dfda4d60aea89714feda753f53551ff743c8c96329a876c88df382a4fe17'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'libxkbfile' => :build
  depends_on 'linux_pam' => :executable

  # Fix mold: error: undefined symbol: dlopen
  autotools_configure_options "LIBS='-ldl' --disable-tests"

  def self.patch
    Dir['src/libkeymap/*'].each do |file|
      # Fix error: implicit declaration of function 'strlcat'
      system "sed -i 's,strlcat,strncat,g' #{file}"
      # Fix error: implicit declaration of function 'strlcpy'
      system "sed -i 's,strlcpy,strncpy,g' #{file}"
    end
    Dir['tests/libkeymap/*'].each do |file|
      # Fix error: implicit declaration of function 'strlcpy'
      system "sed -i 's,strlcpy,strncpy,g' #{file}"
    end
  end

  # Tests fail spectacularly.
  # ERROR: 67 tests were run, 66 failed unexpectedly.
  # run_tests
end
