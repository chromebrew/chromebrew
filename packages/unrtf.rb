require 'package'

class Unrtf < Package
  description 'UnRTF is a command-line program written in C which converts documents in Rich Text Format (.rtf) to HTML, LaTeX, troff macros, and RTF itself.'
  homepage 'https://www.gnu.org/software/unrtf/'
  version '0.21.9'
  compatibility 'all'
  source_url 'https://www.gnu.org/software/unrtf/unrtf-0.21.9.tar.gz'
  source_sha256 '22a37826f96d754e335fb69f8036c068c00dd01ee9edd9461a36df0085fb8ddd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unrtf-0.21.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unrtf-0.21.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unrtf-0.21.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unrtf-0.21.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '60ac4110be548c1d7f52210f30b2af30774ca532b245778badd0f5ecec4fc669',
     armv7l: '60ac4110be548c1d7f52210f30b2af30774ca532b245778badd0f5ecec4fc669',
       i686: 'c6ebb018e9c82cede4d0847b00c4cea44b209ca4f23ffa404d62276d6baa95d1',
     x86_64: '905c08e45a27b7a40aa2986ce9576f24fc36118f185dad78cd728cef51af8e54',
  })

  def self.build
    system './bootstrap'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      '--disable-depedency-tracking',
      '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
