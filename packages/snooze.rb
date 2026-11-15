require 'buildsystems/autotools'

class Snooze < Autotools
  description 'run a command at a particular time'
  homepage 'https://github.com/leahneukirchen/snooze'
  version '0.6'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://github.com/leahneukirchen/snooze.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2c83dd4bd9ddbac02f0996eecd7e14f84a0660bc38b027489e67b2002a13cfef',
     armv7l: '2c83dd4bd9ddbac02f0996eecd7e14f84a0660bc38b027489e67b2002a13cfef',
       i686: '892a2716b862bf9092df95987082e30725b0bcaf80c2ad2294229b5f58ddf4c1',
     x86_64: '461a2ccd9a1b00fe2919338759e9f2f2397abb802633fa109fb658c68dab5ed7'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  autotools_skip_configure
end
