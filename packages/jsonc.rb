require 'package'

class Jsonc < Package
  description 'JSON-C implements a reference counting object model that allows you to easily construct JSON objects in C, output them as JSON formatted strings and parse JSON formatted strings back into the C representation of JSON objects.'
  homepage 'https://github.com/json-c/json-c'
  version '0.16-20220414'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/json-c/json-c/archive/json-c-0.16-20220414.tar.gz'
  source_sha256 '3ecaeedffd99a60b1262819f9e60d7d983844073abc74e495cb822b251904185'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-20220414_armv7l/jsonc-0.16-20220414-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-20220414_armv7l/jsonc-0.16-20220414-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-20220414_i686/jsonc-0.16-20220414-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jsonc/0.16-20220414_x86_64/jsonc-0.16-20220414-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '523484dc50062e441e8c9b79a0accf1af0d5bd4efe480e1e1eaa38890ac8220e',
     armv7l: '523484dc50062e441e8c9b79a0accf1af0d5bd4efe480e1e1eaa38890ac8220e',
       i686: '555a7253bb6bb49ca5134e76daebac0d49179ebfdefe96d4c4c164a78b57f75a',
     x86_64: '5695955d3b4cd29258a09d667ec70fcb5275499777625c242b4c8f93de77df97'
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system "cmake .. #{CREW_CMAKE_OPTIONS}"
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/libjson-c.so.4", "#{CREW_DEST_LIB_PREFIX}/libjson-c.so.3"
    end
  end
end
