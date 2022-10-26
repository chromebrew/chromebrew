require 'package'

class Bz3 < Package
  description 'bzip3 is a better and stronger spiritual successor to bzip2.'
  homepage 'https://github.com/kspalaiologos/bzip3'
  @_ver = '1.1.8'
  version @_ver
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/kspalaiologos/bzip3.git'
  git_hashtag @_ver

  depends_on 'glibc' # R

  def self.patch
    # Remove autoreconf from bootstrap.sh: we'll run it ourselves
    system "sed -i 's:^autoreconf:#autoreconf:g' bootstrap.sh"

    # Replace /bin/sh shebangs with /usr/bin/env sh ones
    %w[bz3cat bz3grep bz3less bz3more bunzip3].each do |file|
      system "sed -i 's:^#!/bin/sh:#!/usr/bin/env sh:' #{file}"
    end

    # Add support for most
    FileUtils.cp 'bz3less', 'bz3most'
    system "sed -i 's:less:most:g' bz3most"
    system "sed -i 's: bz3less : bz3less bz3most :g' Makefile.am"

    FileUtils.cp 'bz3less.1', 'bz3most.1'
    system "sed -i 's:less:most:g' bz3most.1"
    system "sed -i 's: bz3less.1 : bz3less.1 bz3most.1 :g' Makefile.am"
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
