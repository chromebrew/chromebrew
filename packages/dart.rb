require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://dart.dev'
  version '3.12.0'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'

  source_url({
    aarch64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     armv7l: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-arm-release.zip",
     x86_64: "https://storage.googleapis.com/dart-archive/channels/stable/release/#{version}/sdk/dartsdk-linux-x64-release.zip"
  })
  source_sha256({
    aarch64: 'c8919bba2fa9f72801d709485fcff27f73f0cc58d3f3f5dd056a44a317848ffc',
     armv7l: 'c8919bba2fa9f72801d709485fcff27f73f0cc58d3f3f5dd056a44a317848ffc',
     x86_64: '45773140810cfd433402a58bb2ead4f43cc55805c34d2de0641c51012591d65c'
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
