require 'buildsystems/autotools'

class Bzip3 < Autotools
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
    aarch64: 'ddae2ced31503cc95fcddd9a4096e9e168b5131c04b09dd0ffc244e6c08af932',
     armv7l: 'ddae2ced31503cc95fcddd9a4096e9e168b5131c04b09dd0ffc244e6c08af932',
       i686: '6ec989a8febe4ee3ee4bb44a4528a1ecdf49db96567eccc5b8d63713c8a5c3f8',
     x86_64: 'a42f2097c6fd100549c88443668f8d5c75c721459bbd35b3455b7d056e54ce94'
  })

  depends_on 'glibc' # R

  def self.patch
    # Remove autoreconf from bootstrap.sh: we'll run it ourselves
    system "sed -i 's:^autoreconf:#autoreconf:g' bootstrap.sh"

    # Replace /bin/sh shebangs with /usr/bin/env sh ones
    %w[bz3cat bz3grep bz3less bz3more bunzip3].each do |file|
      system "sed -i 's:^#!/bin/sh:#!/usr/bin/env sh:' #{file}"
    end
  end

  configure_options '--disable-arch-native'

  run_tests
end
