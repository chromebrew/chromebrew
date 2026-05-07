require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev'
  version '3.11.6'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'

  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: 'ba594177d23c372c02a80dbeacd418094f78f44bfb67a60636cc32eafb662185',
     armv7l: 'ba594177d23c372c02a80dbeacd418094f78f44bfb67a60636cc32eafb662185',
     x86_64: 'ea0ff2396ea5af402ba3598a9139a0f4b1b3471d9d7e834882d1559622760add'
  })

  conflicts_with 'flutter'
  no_compile_needed
  no_shrink

  def self.install
    dart_prefix = File.join(CREW_LIB_PREFIX, 'dart')

    FileUtils.mkdir_p [CREW_DEST_LIB_PREFIX, File.join(CREW_DEST_PREFIX, 'bin')]
    FileUtils.cp_r '.', File.join(CREW_DEST_DIR, dart_prefix)

    FileUtils.ln_s File.join(dart_prefix, 'bin/dart'), File.join(CREW_DEST_PREFIX, 'bin/dart')
  end
end
