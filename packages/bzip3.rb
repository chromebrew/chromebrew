require 'package'

class Bzip3 < Package
  description 'bzip3 is a better and stronger spiritual successor to bzip2.'
  homepage 'https://github.com/kspalaiologos/bzip3'
  version '1.2.2'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/kspalaiologos/bzip3.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz3/1.2.2_armv7l/bz3-1.2.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz3/1.2.2_armv7l/bz3-1.2.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz3/1.2.2_i686/bz3-1.2.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bz3/1.2.2_x86_64/bz3-1.2.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4307ccc04d65a7632205b5661e37df6cfe6d939e98e729dcb5be65e05c2066ec',
     armv7l: '4307ccc04d65a7632205b5661e37df6cfe6d939e98e729dcb5be65e05c2066ec',
       i686: '96c4b7cf3a3e7bc9a83ff99726d1e4a09966e292681bab6088a2ee44c4d1b4a9',
     x86_64: '3d838d809d58ad1714ade25426838646373e1ecf37ae53b733291a946321256a'
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

  def self.build
    system './bootstrap.sh'
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS} \
              --disable-arch-native"
    system 'make'
  end

  def self.check
    # At the time of writing (17 Oct 2022), bzip3 has no checks
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
