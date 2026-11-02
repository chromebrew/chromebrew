require 'buildsystems/cmake'

class Bzip3 < CMake
  description 'bzip3 is a better and stronger spiritual successor to bzip2.'
  homepage 'https://github.com/kspalaiologos/bzip3'
  version '1.5.5'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/kspalaiologos/bzip3.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b2a83ade46e365044bb7ac23dd5e21b04cf8d28850d46ff0dd8a3ddb21c8d62',
     armv7l: '6b2a83ade46e365044bb7ac23dd5e21b04cf8d28850d46ff0dd8a3ddb21c8d62',
       i686: '386bf208bc42977fda095b591307b75e03216ed8e26c1dcd29e4f909e2d43ff8',
     x86_64: '3e9f851243a1753024a64a9facf6247e9604f8816c9a7968d8640a16b33a1056'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.patch
    # Replace /bin/sh shebangs with /usr/bin/env sh ones
    %w[bz3cat bz3grep bz3less bz3more bunzip3].each do |file|
      system "sed -i 's:^#!/bin/sh:#!/usr/bin/env sh:' #{file}"
    end
  end
end
