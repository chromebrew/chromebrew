require 'package'

class Dart < Package
  description 'The Dart SDK is a set of tools and libraries for the Dart programming language.  You can find information about Dart online at dartlang.org.'
  homepage 'https://www.dartlang.org'
  version '1.24.2'
  case ARCH
  when 'i686'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-ia32-release.zip'
    source_sha1 '24d132e12d7982ae0c7f41bf78e7e45aaae303cb'
  when 'x86_64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-x64-release.zip'
    source_sha1 'c2ff2a1c499b1dd3f8e547d7f012fabf46e06108'
  when 'armv7l'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-arm-release.zip'
    source_sha1 'c14d211981c405a754963941d3c8be6d0da22a8c'
  when 'aarch64'
    source_url 'https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.2/sdk/dartsdk-linux-arm64-release.zip'
    source_sha1 'cf6b96eb5b88b1865bf357c2c9fd7ad8d64f763f'
#  
#  comment out abort per discussion in #798
#  https://github.com/skycocker/chromebrew/pull/798
#  we have all current archs covered here anyway, i believe
#
#  else
#    abort 'Unable to install dart sdk.  Architecture not supported.'.lightred
  end
  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local"
    system "cp -r bin/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r lib/ #{CREW_DEST_DIR}/usr/local"
    system "cp -r include/ #{CREW_DEST_DIR}/usr/local"
  end
end
