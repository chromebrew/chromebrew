require 'package'

class Choose < Package
  description 'make choices on the command line'
  homepage 'https://github.com/geier/choose/'
  @_ver = '0.1.0'
  version @_ver + '-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/geier/choose.git'
  git_hashtag 'v' + @_ver

  depends_on 'py3_urwid'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "sed -i 's:#!/usr/bin/env python:#!#{CREW_PREFIX}/bin/python3:' choose"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREIFX}/bin/"
    FileUtils.install "choose", "#{CREW_DEST_PREFIX}/bin/choose", mode: 0755, verbose: true
  end
end
