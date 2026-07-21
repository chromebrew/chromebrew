require 'digest/sha2'
require 'minitest/autorun'
require_relative '../../commands/download'
require_relative '../../lib/const'
require_relative '../../lib/package'
require_relative '../../lib/package_utils'

# Add lib to LOAD_PATH
$LOAD_PATH << File.join(CREW_LIB_PATH, 'lib')

class DownloadCommandTest < Minitest::Test
  def test_precompiled_download
    pkg = Package.load_package('gnome_common.rb')
    meta = Command.download(pkg)
    refute(meta[:source])
    assert_equal(PackageUtils.get_sha256(pkg), Digest::SHA256.hexdigest(File.read(File.join(CREW_BREW_DIR, meta[:filename]))))
  end

  def test_regular_source_download
    pkg = Package.load_package('ctorrent.rb')
    meta = Command.download(pkg, opt_source: true)
    assert(meta[:source])
    assert_equal(PackageUtils.get_sha256(pkg, build_from_source: true), Digest::SHA256.hexdigest(File.read(File.join(CREW_BREW_DIR, meta[:filename]))))
  end

  def test_skip_source_download
    pkg = Package.load_package('json2csv.rb')
    meta = Command.download(pkg, opt_source: true)
    assert(meta[:source])
    assert_equal('SKIP', meta[:filename])
  end

  def test_unusual_source_download
    pkg = Package.load_package('nmon.rb')
    meta = Command.download(pkg, opt_source: true)
    assert(meta[:source])
    assert_equal(PackageUtils.get_sha256(pkg, build_from_source: true), Digest::SHA256.hexdigest(File.read(File.join(CREW_BREW_DIR, meta[:extract_dir], meta[:filename]))))
  end

  def test_fake_download
    assert_raises(SystemExit) { Command.download(Package.load_package('buildessential.rb')) }
  end
end
