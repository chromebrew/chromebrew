require 'buildsystems/cmake'

class Bzip3 < CMake
  description 'bzip3 is a better and stronger spiritual successor to bzip2.'
  homepage 'https://github.com/kspalaiologos/bzip3'
  version '1.3.2'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/kspalaiologos/bzip3.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip3/1.3.2_armv7l/bzip3-1.3.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip3/1.3.2_armv7l/bzip3-1.3.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip3/1.3.2_i686/bzip3-1.3.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bzip3/1.3.2_x86_64/bzip3-1.3.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'be209e1db7a1796e8d9c579dcb9333ff3a6ebcdfac952a5988fca6861c2e24bb',
     armv7l: 'be209e1db7a1796e8d9c579dcb9333ff3a6ebcdfac952a5988fca6861c2e24bb',
       i686: '3b8b55a9f2922d151bc78a9632fd90e2aa68bc3a38caed04062ed2c651629f47',
     x86_64: '44c65bda8559e0cb0682173058f22f87f3be44a8d9d3ac2e9fbc90e89b06dd0c'
  })

  depends_on 'glibc' # R

  def self.patch
    # Replace /bin/sh shebangs with /usr/bin/env sh ones
    %w[bz3cat bz3grep bz3less bz3more bunzip3].each do |file|
      system "sed -i 's:^#!/bin/sh:#!/usr/bin/env sh:' #{file}"
    end
  end
end
