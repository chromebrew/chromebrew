require 'buildsystems/cmake'

class Bzip3 < CMake
  description 'bzip3 is a better and stronger spiritual successor to bzip2.'
  homepage 'https://github.com/kspalaiologos/bzip3'
  version '1.5.3'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/kspalaiologos/bzip3.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f862098e0b396f1473901ebf2cea3ec2c321052a4ff9c6ebc70cca7faf22b9fa',
     armv7l: 'f862098e0b396f1473901ebf2cea3ec2c321052a4ff9c6ebc70cca7faf22b9fa',
       i686: '7f870a0db7419f90ad33ff8c68550d8254b85c4ae74e05f25a92254bb97f1cd7',
     x86_64: '7eb5b723fed0ddc10ba74b5032ff119722d6556db2183b66fdc275669803cd56'
  })

  depends_on 'glibc' # R

  def self.patch
    # Replace /bin/sh shebangs with /usr/bin/env sh ones
    %w[bz3cat bz3grep bz3less bz3more bunzip3].each do |file|
      system "sed -i 's:^#!/bin/sh:#!/usr/bin/env sh:' #{file}"
    end
  end
end
