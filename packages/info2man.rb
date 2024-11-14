require 'package'

class Info2man < Package
  description 'Convert GNU info files to POD or man pages.'
  homepage 'https://www.cskk.ezoshosting.com/cs/css/info2pod.html'
  version '1.1-10'
  license 'unknown'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/info2man.git'
  git_hashtag "debian/#{version}"

  def self.patch
    system "sed -i 's:#!/usr/bin/perl:#!#{CREW_PREFIX}/bin/perl:g' 0README.txt info2pod"
    system "sed -i 's:#!/bin/sh:#!/usr/bin/env sh:g' info2man"
  end

  def self.install
    @_perl_version = `echo "printf '%vd', $^V;" | perl`.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/perl5/site_perl/#{@_perl_version}/"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'info2man', "#{CREW_DEST_PREFIX}/bin/info2man", mode: 0o755
    FileUtils.install 'info2pod', "#{CREW_DEST_PREFIX}/bin/info2pod", mode: 0o755
    FileUtils.cp_r 'cs', "#{CREW_DEST_PREFIX}/lib/perl5/site_perl/#{@_perl_version}/"
    FileUtils.install 'debian/info2man.1', "#{CREW_DEST_MAN_PREFIX}/man1/info2man.1"
    FileUtils.install 'debian/info2pod.1', "#{CREW_DEST_MAN_PREFIX}/man1/info2pod.1"
  end
end
